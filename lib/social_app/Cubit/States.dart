abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final String error;

  SocialGetUserErrorState(this.error);
}

// get all users

class SocialGetAllUsersLoadingState extends SocialStates {}

class SocialGetAllUsersSuccessState extends SocialStates {}

class SocialGetAllUsersErrorState extends SocialStates {
  final String error;

  SocialGetAllUsersErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates {}

class SocialNewPostState extends SocialStates {}

class SocialGetProfileImageLoadingState extends SocialStates {}

class SocialGetProfileImageSuccessState extends SocialStates {}

class SocialGetProfileImageErrorState extends SocialStates {}

class SocialGetCoverImageLoadingState extends SocialStates {}

class SocialGetCoverImageSuccessState extends SocialStates {}

class SocialGetCoverImageErrorState extends SocialStates {}

class SocialUpLoadCoverImageLoadingState extends SocialStates {}

class SocialUpLoadCoverImageSuccessState extends SocialStates {}

class SocialUpLoadCoverImageErrorState extends SocialStates {}

class SocialUpLoadProfileImageLoadingState extends SocialStates {}

class SocialUpLoadProfileImageSuccessState extends SocialStates {}

class SocialUpLoadProfileImageErrorState extends SocialStates {}

class SocialUpDateUserErrorState extends SocialStates {}

class SocialUpDateUserLoadingState extends SocialStates {}

// UpLoad post

class UpLoadPostErrorState extends SocialStates {}

class UpLoadPostSuccessState extends SocialStates {}

class UpLoadPostLoadingState extends SocialStates {}

class RemovePostImageState extends SocialStates {}

// Get post image

class GetPostImageSuccessState extends SocialStates {}

class GetPostImageErrorState extends SocialStates {}

class GetPostImageLoadingState extends SocialStates {}

// UpLoad post image

class UpLoadPostImageErrorState extends SocialStates {}

class UpLoadPostImageSuccessState extends SocialStates {}

class UpLoadPostImageLoadingState extends SocialStates {}

class GetPostsErrorState extends SocialStates {}

class GetPostsSuccessState extends SocialStates {}

class GetPostsLoadingState extends SocialStates {}

// Put a post like .

class LikeAPostsSuccessState extends SocialStates {}

class LikeAPostsErrorState extends SocialStates {}
