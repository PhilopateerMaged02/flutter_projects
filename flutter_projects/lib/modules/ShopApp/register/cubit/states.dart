import 'package:news_app/models/shop_app/login_model.dart';

abstract class ShopAppRegisterStates{}
class ShopAppRegisterInitialState extends ShopAppRegisterStates{}

class ShopAppRegisterLoadingState extends ShopAppRegisterStates{}

class ShopAppRegisterSuccessState extends ShopAppRegisterStates
{
  final ShoploginModel loginModel;
  ShopAppRegisterSuccessState(this.loginModel);
}

class ShopAppRegisterErrorState extends ShopAppRegisterStates
{
  final String error;
  ShopAppRegisterErrorState(this.error);
}

class ShopChangeRegisterVisibilityState extends ShopAppRegisterStates{}