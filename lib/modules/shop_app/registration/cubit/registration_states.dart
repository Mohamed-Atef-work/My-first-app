import '../../../../models/shop_models/registration_error_model.dart';
import '../../../../models/shop_models/registration_model.dart';

abstract class ShopRegistrationStates {}

class ShopRegistrationInitialState extends ShopRegistrationStates {}

class ShopRegistrationLoadingState extends ShopRegistrationStates {}

class ShopRegistrationSuccessState extends ShopRegistrationStates {
  late final RegistrationModel registrationModel;

  ShopRegistrationSuccessState(this.registrationModel);
}

class ShopRegistrationErrorState extends ShopRegistrationStates {
  late final String error;
  late final RegistrationErrorModel registrationErrorModel;

  ShopRegistrationErrorState(this.error, this.registrationErrorModel);
}

class ShopRegistrationChangVisibilityState extends ShopRegistrationStates {}
