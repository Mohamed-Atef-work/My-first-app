import 'package:my_first_app/models/shop_models/login_model.dart';

abstract class ShopLoginStates{}

class ShopLoginInitialState extends ShopLoginStates{}

class ShopLoginLoadingState extends ShopLoginStates{}

class ShopLoginSuccessState extends ShopLoginStates
{
  late final ShopLoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginStates
{
  late final String error;

  ShopLoginErrorState(this.error);
}

class ShopLoginChangVisibilityState extends ShopLoginStates{}
