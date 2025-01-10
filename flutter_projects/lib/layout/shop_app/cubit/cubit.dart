import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/shop_app/cubit/states.dart';
import 'package:news_app/models/shop_app/categories_model.dart';
import 'package:news_app/models/shop_app/categories_model.dart';
import 'package:news_app/models/shop_app/change_favorites_model.dart';
import 'package:news_app/models/shop_app/favorites_screen_model.dart';
import 'package:news_app/models/shop_app/home_model.dart';
import 'package:news_app/models/shop_app/login_model.dart';
import 'package:news_app/modules/NewsApp/news_settings/settings_screen.dart';
import 'package:news_app/modules/ShopApp/Products/products_screen.dart';
import 'package:news_app/modules/ShopApp/categories/categories_screen.dart';
import 'package:news_app/modules/ShopApp/favorites/favorites_screen.dart';
import 'package:news_app/modules/ShopApp/settings/settings_screen.dart';
import 'package:news_app/shared/components/constants.dart';
import 'package:news_app/shared/network/end_points.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class ShopAppCubit extends Cubit<ShopStates>
{
  ShopAppCubit() : super(ShopInitialState());

  static ShopAppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> BottomScreens =
  [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingssScreen(),
  ];
  void changeIndexButtom(int index)
  {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }
  HomeModel? homeModel;
  Map<int,bool> favorites = {};
  void getHomeData()
  {
    emit(ShopLoadingHomeState());
    DioHelper.getData(
        url: HOME,
      lang: 'en',
      token: token
    ).then((value)
    {
      homeModel = HomeModel.fromJson(value.data);
      print(token);
      homeModel!.data.Products.forEach((element)
      {
        favorites.addAll({
          element.id : element.inFavorites
        });
      });
      print(favorites.toString());
      emit(ShopLoadingHomeSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopLoadingHomeErrorState());
    });
  }
  categoriesModel? CategoriesModel;
  void getCategoriesData()
  {
    //emit(ShopLoadingHomeState());
    DioHelper.getData(
        url: CATEGORIES,
        lang: 'en',
        token: token
    ).then((value)
    {
      CategoriesModel = categoriesModel.fromJson(value.data);
      emit(ShopLoadingCategoriesSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopLoadingCategoriesErrorState());
    });
  }
  favoritesModel? FavoritesModel;
void changeFavorites(int id)
{
  favorites[id] = !favorites[id]!;
  emit(ShopLoadingChangeFavoritesState());
  DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id':id,
      },
  token: token,
  ).then((value){
    FavoritesModel = favoritesModel.fromJson(value.data);
    if(!FavoritesModel!.status)
    {
      favorites[id] = !favorites[id]!;
    }
    else
    {
      getFavoritesData();
    }
    emit(ShopLoadingChangeFavoritesSuccessState(FavoritesModel!));
  }).catchError((error){
    favorites[id] = !favorites[id]!;
    emit(ShopLoadingChangeFavoritesErrorState());
  });
}
FavoritesScreenModel? favoritesScreenmodel;
  void getFavoritesData()
  {
    emit(ShopLoadingFavoritesState());
    DioHelper.getData(
        url: FAVORITES,
        lang: 'en',
        token: token
    ).then((value)
    {
      favoritesScreenmodel = FavoritesScreenModel.fromJson(value.data);
      emit(ShopLoadingGetFavoritesSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopLoadingGetFavoritesErrorState());
    });
  }

  ShoploginModel? userModel;
void getProfile()
{
  emit(ShopLoadingProfileState());
  DioHelper.getData(
      url: PROFILE,
    lang: 'en',
    token: token,
  ).then((value)
  {
    userModel = ShoploginModel.fromJson(value.data);
    printFullText(userModel?.data?.name ?? '');
    emit(ShopLoadingProfileSuccessState(userModel!));
  }).catchError((error)
  {
    emit(ShopLoadingProfileErrorState());
  });
}
void updateUserData({
    required String name,
    required String email,
    required String phone,
})
{
  emit(ShopLoadingUpdateProfileState());
  DioHelper.putData(
    url: UPDATE_PROFILE,
    lang: 'en',
    token: token,
    data: {
      'name':name,
      'email':email,
      'phone':phone,
    },
  ).then((value)
  {
    userModel = ShoploginModel.fromJson(value.data);
    printFullText(userModel?.data?.name ?? '');
    emit(ShopLoadingUpdateProfileSuccessState(userModel!));
  }).catchError((error)
  {
    emit(ShopLoadingUpdateProfileErrorState());
  });
}







}
