import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/modules/shop_app/search/cubit/states.dart';

import '../../../../models/shop_models/search_products_model.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/network/remote/dio_helper.dart';
import '../../../../shared/network/remote/end_points.dart';

class ShopSearchCubit extends Cubit<ShopSearchStates> {
  ShopSearchCubit() : super(ShopLoadingSearchProductsInitialState());

  static ShopSearchCubit get(context) => BlocProvider.of(context);

  SearchProductsModel? searchProductsModel;
  void getSearchProductsData({
    required String search,
  }) {
    emit(ShopLoadingSearchProductsState());

    DioHelper.postData(
      url: SEARCH,
      token: token,
      lang: "en",
      data: {
        "text": search,
      },
    ).then((value) {
      print("-_______IN The method of Search__________-");
      searchProductsModel = SearchProductsModel.fromJson(value!.data);
      print("The state of Search is ${searchProductsModel!.status}");

      emit(ShopSuccessSearchProductsState(searchProductsModel!));
    }).catchError((error) {
      print(error.toString());

      emit(ShopErrorSearchProductsState());
    });
  }
}
