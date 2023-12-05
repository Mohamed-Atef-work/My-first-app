import 'package:my_first_app/models/shop_models/change_favorites_model.dart';
import 'package:my_first_app/models/shop_models/profile_model.dart';
import 'package:my_first_app/models/shop_models/registration_model.dart';
import 'package:my_first_app/models/shop_models/search_products_model.dart';

import '../../../models/shop_models/registration_error_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopChangeBottomNaveState extends ShopStates {}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

class ShopLoadingCategoriesState extends ShopStates {}

class ShopChangedFavoritesState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates {
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopStates {}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {}

class ShopLoadingGetUserDataState extends ShopStates {}

class ShopSuccessGetUserDataState extends ShopStates {
  final ProfileModel userData;

  ShopSuccessGetUserDataState(this.userData);
}

class ShopErrorGetUserDataState extends ShopStates {}

class ShopLoadingUpDateUserDataState extends ShopStates {}

class ShopSuccessUpDateUserDataState extends ShopStates {
  final RegistrationModel upDateUserDataModel;

  ShopSuccessUpDateUserDataState(this.upDateUserDataModel);
}

class ShopErrorUpDateUserDataState extends ShopStates {
  final RegistrationErrorModel upDateErrorUserDataModel;

  ShopErrorUpDateUserDataState(this.upDateErrorUserDataModel);
}


