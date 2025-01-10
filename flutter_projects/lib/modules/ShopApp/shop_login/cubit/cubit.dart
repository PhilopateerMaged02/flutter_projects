import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/shop_app/login_model.dart';
import 'package:news_app/modules/ShopApp/shop_login/cubit/states.dart';
//import 'package:news_app/modules/shop_login/cubit/states.dart';
import 'package:news_app/shared/network/end_points.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopAppLoginStates>
{
  ShopLoginCubit() : super(ShopAppLoginInitialState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);


  ShoploginModel? loginModel ;
  void loginUser({
    required String email,
    required String password
})
  {
    emit(ShopAppLoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {
          'email':email,
          'password':password
        }).then((value)
        {
          print(value.data);
          loginModel = ShoploginModel.fromJson(value.data);
          print(loginModel!.status);
          print(loginModel!.message);
          print(loginModel!.data!.token);
          emit(ShopAppLoginSuccessState(loginModel!));
        }).catchError((error) {
      print("Error in loginUser: $error");
      emit(ShopAppLoginErrorState(error.toString()));
    });

  }
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangeVisibilityState());
  }
}