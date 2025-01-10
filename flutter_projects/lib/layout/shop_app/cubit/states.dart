import 'package:news_app/models/shop_app/change_favorites_model.dart';
import 'package:news_app/models/shop_app/login_model.dart';
import 'package:news_app/modules/ShopApp/shop_login/cubit/cubit.dart';

abstract class ShopStates {}
class ShopInitialState extends ShopStates{}
class ShopChangeBottomNavState extends ShopStates{}
//home screen states
class ShopLoadingHomeState extends ShopStates{}
class ShopLoadingHomeSuccessState extends ShopStates{}
class ShopLoadingHomeErrorState extends ShopStates{}
//categories screen states
class ShopLoadingCategoriesSuccessState extends ShopStates{}
class ShopLoadingCategoriesErrorState extends ShopStates{}
//favorites screen states
class ShopLoadingChangeFavoritesState extends ShopStates{}
class ShopLoadingChangeFavoritesSuccessState extends ShopStates
{
  final favoritesModel FavoritesModel;
  ShopLoadingChangeFavoritesSuccessState(this.FavoritesModel);
}
class ShopLoadingChangeFavoritesErrorState extends ShopStates{}
//favorites Screen
class ShopLoadingGetFavoritesSuccessState extends ShopStates{}
class ShopLoadingGetFavoritesErrorState extends ShopStates{}
class ShopLoadingFavoritesState extends ShopStates{}

//profile States
class ShopLoadingProfileState extends ShopStates{}
class ShopLoadingProfileSuccessState extends ShopStates
{
  final ShoploginModel loginModel;
  ShopLoadingProfileSuccessState(this.loginModel);
}
class ShopLoadingProfileErrorState extends ShopStates{}
//UPDATE STATES
class ShopLoadingUpdateProfileState extends ShopStates{}
class ShopLoadingUpdateProfileSuccessState extends ShopStates
{
  final ShoploginModel loginModel;
  ShopLoadingUpdateProfileSuccessState(this.loginModel);
}
class ShopLoadingUpdateProfileErrorState extends ShopStates{}
