import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/shop_app/login_model.dart';
import 'package:news_app/modules/ShopApp/register/cubit/states.dart';
import 'package:news_app/modules/ShopApp/shop_login/cubit/states.dart';
//import 'package:news_app/modules/shop_login/cubit/states.dart';
import 'package:news_app/shared/network/end_points.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopAppRegisterStates>
{
  ShopRegisterCubit() : super(ShopAppRegisterInitialState());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);


  ShoploginModel? loginModel ;
  void RegisterUser({
    required String email,
    required String password,
    required String name,
    required String phone,
})
  {
    emit(ShopAppRegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data: {
          'email':email,
          'phone':phone,
          'name':name,
          'password':password
        }).then((value)
        {
          print(value.data);
          loginModel = ShoploginModel.fromJson(value.data);
          print(loginModel!.status);
          print(loginModel!.message);
          print(loginModel!.data!.token);
          emit(ShopAppRegisterSuccessState(loginModel!));
        }).catchError((error) {
      print("Error in loginUser: $error");
      emit(ShopAppRegisterErrorState(error.toString()));
    });

  }
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangeRegisterVisibilityState());
  }
}