import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/models/user/user_model.dart';
import 'package:my_first_app/social_app/modules/registration/cubit/registration_states.dart';

import '../../../models/registration_error_model.dart';
import '../../../models/registration_model.dart';
import '../../../models/user_model.dart';

class SocialRegistrationCubit extends Cubit<SocialRegistrationStates> {
  SocialRegistrationCubit() : super(SocialRegistrationInitialState());

  static SocialRegistrationCubit get(context) => BlocProvider.of(context);

  SocialRegistrationModel? registrationModel;
  SocialRegistrationErrorModel? registrationErrorModel;
  //var valueData;

  void userRegistration({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) {
    emit(SocialRegistrationLoadingState());
    print("----->>>------Loading Registration------<<<-----");

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);

      createUser(
        name: name,
        email: email,
        phone: phone,
        uId: value.user!.uid,
      );
    }).catchError((error) {
      emit(SocialRegistrationErrorState(error.toString()));
    });
  }

  void createUser({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    SocialUserModel userModel = SocialUserModel(
      uId: uId,
      name: name,
      email: email,
      phone: phone,
      isEmailVerified: false,
      bio: "write your bio.....",
      cover:
          "https://images.pexels.com/photos/4215110/pexels-photo-4215110.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      image:
          "https://images.pexels.com/photos/4309369/pexels-photo-4309369.jpeg",
    );

    FirebaseFirestore.instance
        .collection("user")
        .doc(uId)
        .set(userModel.toJson())
        .then((value) {
      emit(SocialRegistrationCreateUserSuccessState());
    }).catchError((error) {
      emit(SocialRegistrationCreateUserErrorState(error.toString()));
    });
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(SocialRegistrationChangVisibilityState());
  }
}
