import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:my_first_app/models/user/user_model.dart';
import 'package:my_first_app/shared/components/components.dart';
import 'package:my_first_app/social_app/Cubit/Cubit.dart';
import 'package:my_first_app/social_app/Cubit/States.dart';

class EditProfileScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        var userModel = SocialCubit.get(context).socialUserModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text = SocialCubit.get(context).socialUserModel!.name;
        emailController.text = SocialCubit.get(context).socialUserModel!.email;
        phoneController.text = SocialCubit.get(context).socialUserModel!.phone;
        bioController.text = SocialCubit.get(context).socialUserModel!.bio!;

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: "Edit your profile",
            actions: [
              defaultTextButton(
                text: "UPDATE",
                function: () {
                  SocialCubit.get(context).upDateUserData(
                    bio: bioController.text,
                    phone: phoneController.text,
                    email: emailController.text,
                    name: nameController.text,
                  );
                },
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is SocialUpDateUserLoadingState)
                    LinearProgressIndicator(),
                  if (state is SocialUpDateUserLoadingState)
                    SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 230,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              SizedBox(
                                child: coverImage == null
                                    ? Image.network(
                                        userModel!.cover!,
                                        width: double.infinity,
                                        height: 170,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.file(
                                        coverImage,
                                        width: double.infinity,
                                        height: 170,
                                        fit: BoxFit.cover,
                                      ),
                                //width: double.infinity,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: CircleAvatar(
                                  radius: 20,
                                  child: IconButton(
                                    onPressed: () {
                                      SocialCubit.get(context).getCoverImage();
                                    },
                                    icon: Icon(IconlyBroken.camera),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        CircleAvatar(
                          radius: 65,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundImage: profileImage == null
                                    ? Image.network(userModel!.image!).image
                                    : FileImage(profileImage),
                              ),
                              CircleAvatar(
                                radius: 20,
                                child: IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).getProfileImage();
                                  },
                                  icon: Icon(IconlyBroken.camera),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      if (coverImage != null)
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              SocialCubit.get(context).uploadCoverImage();
                            },
                            child: Text("upData cover image"),
                          ),
                        ),
                      if (coverImage != null)
                        SizedBox(
                          width: 5,
                        ),
                      if (profileImage != null)
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              SocialCubit.get(context).uploadProfileImage();
                            },
                            child: Text("upData profile image"),
                          ),
                        ),
                    ],
                  ),
                  if (state is SocialUpLoadProfileImageLoadingState ||
                      state is SocialUpLoadCoverImageLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.text,
                    validate: () {},
                    label: "Name",
                    prefix: IconlyBroken.user_3,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  defaultFormField(
                    controller: emailController,
                    type: TextInputType.text,
                    validate: () {},
                    label: "Email",
                    prefix: IconlyBroken.home,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.text,
                    validate: () {},
                    label: "Phone",
                    prefix: IconlyBroken.call,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  defaultFormField(
                    controller: bioController,
                    type: TextInputType.text,
                    validate: () {},
                    label: "Bio",
                    prefix: IconlyBroken.info_circle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
