import 'package:news_app/models/shop_app/login_model.dart';

abstract class ShopAppLoginStates{}
class ShopAppLoginInitialState extends ShopAppLoginStates{}

class ShopAppLoginLoadingState extends ShopAppLoginStates{}

class ShopAppLoginSuccessState extends ShopAppLoginStates
{
  final ShoploginModel loginModel;
  ShopAppLoginSuccessState(this.loginModel);
}

class ShopAppLoginErrorState extends ShopAppLoginStates
{
  final String error;
  ShopAppLoginErrorState(this.error);
}

class ShopChangeVisibilityState extends ShopAppLoginStates{}