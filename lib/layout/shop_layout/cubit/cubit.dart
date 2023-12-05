import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/layout/shop_layout/cubit/states.dart';
import 'package:my_first_app/models/shop_models/categories_model.dart';
import 'package:my_first_app/models/shop_models/home_model.dart';
import 'package:my_first_app/models/shop_models/profile_model.dart';
import 'package:my_first_app/models/shop_models/registration_error_model.dart';
import 'package:my_first_app/models/shop_models/search_products_model.dart';
import 'package:my_first_app/modules/shop_app/categories/catogories_screen.dart';
import 'package:my_first_app/modules/shop_app/favorites/favorites_screen.dart';
import 'package:my_first_app/modules/shop_app/products/products_screen.dart';
import 'package:my_first_app/modules/shop_app/settings/settings_screen.dart';
import 'package:my_first_app/shared/components/constants.dart';
import 'package:my_first_app/shared/network/remote/dio_helper.dart';

import '../../../models/shop_models/change_favorites_model.dart';
import '../../../models/shop_models/favorites_model.dart';
import '../../../models/shop_models/registration_model.dart';
import '../../../shared/network/remote/end_points.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
  List<String> titles = [
    "Products",
    "Categories",
    "Favorites",
    "Settings",
  ];

  void changeBottom(int index) {
    emit(ShopChangeBottomNaveState());
    currentIndex = index;
  }

  HomeModel? homeModel;

  late Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      //print("banners are ${homeModel!.data.banners}");
      print("statue of getting home is ${homeModel!.status}");
      print("image of getting home is ${homeModel!.data.banners[0].image}");

      // put data in the map.
      homeModel!.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });

      print(favorites.toString());

      // put Ids in the Store.
      homeModel!.data.products.forEach((element) {
        Fav.favoritesIds.addAll([element.id]);
      });
      print(Fav.favoritesIds.toString());

      // put bool in the Store.
      homeModel!.data.products.forEach((element) {
        Fav.favoritesBool.addAll([element.inFavorites]);
      });
      print(Fav.favoritesBool.toString());

      /*for(int index = 0; index <= StoreFavorites.favoritesIds.length - 1 ; index++)
      {
        StoreFavorites.favorites[StoreFavorites.favoritesIds[index]] = StoreFavorites.favoritesBool[index];
      }*/

      homeModel!.data.products.forEach((element) {
        Fav.favorites[element.id] = element.inFavorites;
      });

      print(Fav.favorites.toString());

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());

      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategories() {
    emit(ShopLoadingCategoriesState());

    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      print("statue of getting categories is ${categoriesModel!.status}");
      print(
          "name of getting categories is ${categoriesModel!.data.dataOfAllCategories[0].name}");

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());

      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changFavorites(int productId) {
    Fav.favorites[productId] = !Fav.favorites[productId];
    emit(ShopChangedFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        "product_id": productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value?.data);
      print(value?.data);

      if (!changeFavoritesModel!.status) {
        Fav.favorites[productId] = !Fav.favorites[productId];
      } else {
        getFavorites();
      }

      //favorites[productId] ??= !favorites[productId];
      //StoreFavorites.favorites[productId] = !StoreFavorites.favorites[productId];

      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      Fav.favorites[productId] = !Fav.favorites[productId];
      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      print("-______Here_______-");
      print(
          "product ID is ${favoritesModel!.data.data[0].product.productId.toString()}");

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());

      emit(ShopErrorGetFavoritesState());
    });
  }

  ProfileModel? userData;
  void getUserData() {
    emit(ShopLoadingGetUserDataState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
      lang: "en",
    ).then((value) {
      print("-_______IN The method__________-");
      userData = ProfileModel.fromJson(value.data);
      print("-_______Before the print__________-");
      print(userData!.data.name);

      emit(ShopSuccessGetUserDataState(userData!));
    }).catchError((error) {
      print(error.toString());

      emit(ShopErrorGetUserDataState());
    });
  }

  RegistrationModel? upDateUserDataModel;
  RegistrationErrorModel? upDateErrorUserDataModel;
  var valueData;

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpDateUserDataState());

    DioHelper.putData(
      url: UPDATE_DATA,
      token: token,
      lang: "en",
      data: {
        "name": name,
        "email": email,
        "phone": phone,
      },
    ).then((value) {
      valueData = value!.data;

      print("-_______IN The Updating method__________-");
      upDateUserDataModel = RegistrationModel.fromJson(valueData);

      print("The UpDated Name is ${upDateUserDataModel!.data.name}");

      if (upDateUserDataModel!.status) {
        getUserData();
      }

      emit(ShopSuccessUpDateUserDataState(upDateUserDataModel!));
    }).catchError((error) {
      print(error.toString());

      upDateErrorUserDataModel = RegistrationErrorModel.fromJson(valueData);

      emit(ShopErrorUpDateUserDataState(upDateErrorUserDataModel!));
    });
  }
}

class Fav {
  static List<bool> favorites = List.generate(100, (index) => true);

  static List<int> favoritesIds = [];
  static List<bool> favoritesBool = [];
}
