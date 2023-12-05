import '../../../../models/shop_models/search_products_model.dart';

abstract class ShopSearchStates{}

class ShopLoadingSearchProductsInitialState extends ShopSearchStates {}

class ShopLoadingSearchProductsState extends ShopSearchStates {}

class ShopSuccessSearchProductsState extends ShopSearchStates {
  final SearchProductsModel searchProductsModel;

  ShopSuccessSearchProductsState(this.searchProductsModel);
}

class ShopErrorSearchProductsState extends ShopSearchStates {

}