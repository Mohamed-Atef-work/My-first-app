import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/layout/shop_layout/cubit/cubit.dart';
import 'package:my_first_app/layout/shop_layout/cubit/states.dart';
import 'package:my_first_app/shared/components/components.dart';
import 'package:my_first_app/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessUpDateUserDataState) {
          showToast(
              text: "${state.upDateUserDataModel.message}",
              state: ToastStates.SUCCESS);
        }
        if (state is ShopErrorUpDateUserDataState) {
          showToast(
              text: "${state.upDateErrorUserDataModel.message}",
              state: ToastStates.Error);
        }
      },
      builder: (context, state) {
        var userData = ShopCubit.get(context).userData;

        nameController.text = userData!.data.name;
        emailController.text = userData.data.email;
        phoneController.text = userData.data.phone;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userData != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if (state is ShopLoadingUpDateUserDataState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    validate: () {},
                    label: "Name",
                    prefix: Icons.drive_file_rename_outline,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validate: () {},
                    label: "label",
                    prefix: Icons.email,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: () {},
                    label: "Phone",
                    prefix: Icons.phone,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                    text: "Sign Out",
                    function: () {
                      signOut(context);
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  defaultButton(
                    text: "Up Date",
                    function: () {
                      if (formKey.currentState!.validate()) {
                        ShopCubit.get(context).updateUserData(
                          phone: phoneController.text,
                          email: emailController.text,
                          name: nameController.text,
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
