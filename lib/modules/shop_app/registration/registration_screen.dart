import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/modules/shop_app/registration/cubit/registration_cubit.dart';
import 'package:my_first_app/modules/shop_app/registration/cubit/registration_states.dart';
import 'package:my_first_app/shared/components/components.dart';

import '../../../layout/shop_layout/shop_layout.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';

class ShopRegistrationScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegistrationCubit(),
      child: BlocConsumer<ShopRegistrationCubit, ShopRegistrationStates>(
        listener: (context, state) {
          if (state is ShopRegistrationSuccessState &&
              state.registrationModel.status) {
            print(state.registrationModel.status);
            print(state.registrationModel.data.token);

            CacheHelper.saveData(
              key: "token",
              value: state.registrationModel.data.token,
            ).then((value) {
              token = state.registrationModel.data.token;

              navigateAndFinish(
                context,
                ShopLayout(),
              );
            });

            showToast(
              text: state.registrationModel.message,
              state: ToastStates.SUCCESS,
            );
          }
          else if(state is ShopRegistrationErrorState)
          {
            showToast(
              text: state.registrationErrorModel.message,
              state: ToastStates.Error,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Text(
                          "REGISTRATION",
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(color: Colors.black),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text("Register now brows our hot offers",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.grey)),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: () {},
                          label: "Name",
                          prefix: Icons.person,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: () {},
                          label: "Email",
                          prefix: Icons.email,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: () {},
                          label: "Phone",
                          prefix: Icons.phone,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: () {},
                          label: "password",
                          prefix: Icons.password_outlined,
                          suffix: ShopRegistrationCubit.get(context).suffix,
                          isPassword:
                              ShopRegistrationCubit.get(context).isPassword,
                          suffixButtonPressed: () {
                            ShopRegistrationCubit.get(context)
                                .changePasswordVisibility();
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegistrationLoadingState,
                          builder: (context) => defaultButton(
                              text: "Register",
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  ShopRegistrationCubit.get(context)
                                      .userRegistration(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                    name: nameController.text,
                                  );
                                }
                              }),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
