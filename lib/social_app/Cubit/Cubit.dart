import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_first_app/social_app/Cubit/States.dart';
import 'package:my_first_app/social_app/models/user_model.dart';
import 'package:my_first_app/social_app/modules/chats/chatsScreen.dart';
import 'package:my_first_app/social_app/modules/users/usersScreen.dart';

import '../../shared/components/constants.dart';
import '../models/post_model.dart';
import '../modules/feeds/feedsScreen.dart';
import '../modules/new_post/new_post_screen.dart';
import '../modules/settings/settingScreen.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  void changBottomNav(int index) {
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      if (index == 1) {
        getAllUsers();
      }
      emit(SocialChangeBottomNavState());
      currentIndex = index;
    }
  }

  SocialUserModel? socialUserModel;

  getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection("user").doc(uId).get().then((value) {
      socialUserModel = SocialUserModel.fromJson(value.data()!);

      print("cover is ---------------------->${socialUserModel!.cover}");

      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print("The Error------------->${error.toString()}");

      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  List<Widget> screens = [
    SocialFeedsScreen(),
    SocialChatsScreen(),
    SocialNewPostScreen(),
    SocialUsersScreen(),
    SocialSettingsScreen(),
  ];

  List<String> titles = [
    "Home",
    "Chats",
    "post",
    "Users",
    "Settings",
  ];

  // image

  var picker = ImagePicker();

  File? profileImage;
  Future<void> getProfileImage() async {
    emit(SocialGetProfileImageLoadingState());
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      profileImage = File(
        pickedImage.path,
      );
      emit(SocialGetProfileImageSuccessState());
    } else {
      print("--------->No image selected");
      emit(SocialGetProfileImageErrorState());
    }
  }

  File? coverImage;
  Future<void> getCoverImage() async {
    emit(SocialGetCoverImageLoadingState());
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      coverImage = File(
        pickedImage.path,
      );
      emit(SocialGetCoverImageSuccessState());
    } else {
      print("--------->No image selected");
      emit(SocialGetCoverImageErrorState());
    }
  }

  void uploadProfileImage() {
    emit(SocialUpLoadProfileImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(profileImage!.path).pathSegments.last}")
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        upDateUserData(
          bio: socialUserModel!.bio!,
          name: socialUserModel!.name,
          email: socialUserModel!.email,
          phone: socialUserModel!.phone,
          profileImage: value,
        );
        profileImage = null;
        emit(SocialUpLoadProfileImageSuccessState());
      }).catchError((error) {});
    }).catchError((error) {
      print("Error is ---------->${error.toString()}");
      emit(SocialUpLoadProfileImageErrorState());
    });
  }

  void uploadCoverImage() {
    emit(SocialUpLoadCoverImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(coverImage!.path).pathSegments.last}")
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        upDateUserData(
          bio: socialUserModel!.bio!,
          name: socialUserModel!.name,
          email: socialUserModel!.email,
          phone: socialUserModel!.phone,
          coverImage: value,
        );
        coverImage = null;
        emit(SocialUpLoadCoverImageSuccessState());
      }).catchError((error) {});
    }).catchError((error) {
      print("Error is ---------->${error.toString()}");
      emit(SocialUpLoadCoverImageErrorState());
    });
  }

  void upDateUserData({
    required String bio,
    required String name,
    required String email,
    required String phone,
    String? profileImage,
    String? coverImage,
  }) {
    emit(SocialUpDateUserLoadingState());

    SocialUserModel upDateUserDataModel = SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      bio: bio,
      uId: socialUserModel!.uId,
      cover: coverImage ?? socialUserModel!.cover,
      image: profileImage ?? socialUserModel!.image,
      isEmailVerified: socialUserModel!.isEmailVerified,
    );

    FirebaseFirestore.instance
        .collection("user")
        .doc(socialUserModel!.uId)
        .update(upDateUserDataModel.toJson())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUpDateUserErrorState());
      print("Error is ------------->${error.toString()}");
    });
  }

  // Getting Post image.
  File? postImage;
  Future<void> getPostImage() async {
    emit(GetPostImageLoadingState());
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      postImage = File(
        pickedImage.path,
      );
      emit(GetPostImageSuccessState());
    } else {
      print("--------->No image selected");
      emit(GetPostImageErrorState());
    }
  }

  //upLoad post image.
  void upLoadPostWithImage({
    required String text,
    required String dateTime,
  }) {
    emit(UpLoadPostImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child("posts/${Uri.file(postImage!.path).pathSegments.last}")
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        upLoadPost(
          text: text,
          dateTime: dateTime,
          postImage: value,
        );

        emit(UpLoadPostImageSuccessState());
      }).catchError((error) {});
    }).catchError((error) {
      print("Error is ---------->${error.toString()}");
      emit(UpLoadPostImageErrorState());
    });
  }

  // upLoading Post
  void upLoadPost({
    required String text,
    required String dateTime,
    String? postImage,
  }) {
    emit(UpLoadPostLoadingState());

    PostModel postModel = PostModel(
      image: socialUserModel!.image!,
      name: socialUserModel!.name,
      uId: socialUserModel!.uId!,
      text: text,
      dateTime: dateTime,
      postImage: postImage ?? "",
    );

    FirebaseFirestore.instance
        .collection("posts")
        .add(postModel.toJson())
        .then((value) {
      emit(UpLoadPostSuccessState());
    }).catchError((error) {
      emit(UpLoadPostErrorState());
      print("Error is ------------->${error.toString()}");
    });
  }

  void removePostImage() {
    postImage = null;
    emit(RemovePostImageState());
  }

  List<PostModel>? posts = [];
  List<String>? postsIds = [];
  List<int>? postLikes = [];

  void getPosts() {
    emit(GetPostsLoadingState());

    FirebaseFirestore.instance.collection("posts").get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection("likes").get().then((value) {
          postLikes!.add(value.size);
          postsIds!.add(element.id);
          posts!.add(PostModel.fromJson(element.data()));
        }).catchError((error) {});
      });
      emit(GetPostsSuccessState());
    }).catchError((error) {
      emit(GetPostsSuccessState());
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .collection("likes")
        .doc(socialUserModel!.uId)
        .set({"like": true}).then((value) {
      emit(LikeAPostsSuccessState());
    }).catchError((error) {
      emit(LikeAPostsErrorState());
    });
  }

  List<SocialUserModel>? users = [];

  void getAllUsers() {
    if (users!.isEmpty) {
      emit(SocialGetAllUsersLoadingState());

      FirebaseFirestore.instance.collection("user").get().then((value) {
        value.docs.forEach((element) {
          if (element.data()["uId"] != socialUserModel!.uId) {
            users!.add(SocialUserModel.fromJson(element.data()));
          }
        });
        emit(SocialGetAllUsersSuccessState());

        print(users![0].name);
      }).catchError((error) {
        emit(SocialGetAllUsersErrorState(error.toString()));
        print(error.toString());
      });
    }
  }
}
