import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/modules/shop_app/registration/cubit/registration_states.dart';
import 'package:my_first_app/shared/network/remote/end_points.dart';

import '../../../../models/shop_models/registration_error_model.dart';
import '../../../../models/shop_models/registration_model.dart';
import '../../../../shared/network/remote/dio_helper.dart';

class ShopRegistrationCubit extends Cubit<ShopRegistrationStates> {
  ShopRegistrationCubit() : super(ShopRegistrationInitialState());

  static ShopRegistrationCubit get(context) => BlocProvider.of(context);

  RegistrationModel? registrationModel;
  RegistrationErrorModel? registrationErrorModel;
  var valueData;

  void userRegistration({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) {
    emit(ShopRegistrationLoadingState());
    print("---------Loading Registration------------");

    DioHelper.postData(
      url: REGISTER,
      data: {
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
      },
    ).then((value) {
      //print(value?.data);
      valueData = value!.data;

      print("-------------Filling the success model----------------");
      registrationModel = RegistrationModel.fromJson(value.data);
      print("---------Filling the success model is done------------");

      print("Then status -------> ${registrationModel!.status}");
      print("Then name   -------> ${registrationModel!.data.name}");
      print("Then phone  -------> ${registrationModel!.data.phone}");
      print("Then token  -------> ${registrationModel!.data.token}");

      print("-------------------SUCCESS----------------------");
      emit(ShopRegistrationSuccessState(registrationModel!));
    }).catchError((error) {
      //print(error.toString());

      print("-------------Filling the error model----------------");
      registrationErrorModel = RegistrationErrorModel.fromJson(valueData);
      print("---------Filling the error model is done------------");

      print("Error status  -------> ${registrationErrorModel!.status}");
      print("Error message -------> ${registrationErrorModel!.message}");

      print("--------------ERROR----------------");
      emit(ShopRegistrationErrorState(
          error.toString(), registrationErrorModel!));
    });
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShopRegistrationChangVisibilityState());
  }
}
