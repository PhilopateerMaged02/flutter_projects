import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/shop_app/cubit/states.dart';
import 'package:news_app/models/shop_app/search_model.dart';
import 'package:news_app/modules/ShopApp/search/cubit/states.dart';
import 'package:news_app/shared/components/constants.dart';
import 'package:news_app/shared/network/end_points.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class ShopSearchCubit extends Cubit<ShopSearchStates>
{
  ShopSearchCubit() : super(ShopSearchInitialState());

  static ShopSearchCubit get(context) =>BlocProvider.of(context);

  SearchScreenModel? searchModel;

  void search(String text)
  {
    emit(ShopSearchLoadingState());
    DioHelper.postData(
        url: SEARCH,
        token: token,
        data:
        {
          'text':text,
        }).then((value){
      searchModel = SearchScreenModel.fromJson(value.data);
          emit(ShopSearchSuccessState());
    }).catchError((error)
    {
      emit(ShopSearchErrorState());
    });
  }
}