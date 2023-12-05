abstract class SocialRegistrationStates {}

class SocialRegistrationInitialState extends SocialRegistrationStates {}

class SocialRegistrationLoadingState extends SocialRegistrationStates {}

class SocialRegistrationSuccessState extends SocialRegistrationStates {
  //late final SocialRegistrationModel registrationModel;

  //SocialRegistrationSuccessState(this.registrationModel);
}

class SocialRegistrationErrorState extends SocialRegistrationStates {
  late final String error;
  //late final SocialRegistrationErrorModel registrationErrorModel;

  SocialRegistrationErrorState(this.error);
}

class SocialRegistrationChangVisibilityState extends SocialRegistrationStates {}

class SocialRegistrationCreateUserLoadingState
    extends SocialRegistrationStates {}

class SocialRegistrationCreateUserSuccessState
    extends SocialRegistrationStates {
  //late final SocialRegistrationModel loginModel;
  //SocialRegistrationSuccessState(this.loginModel);
}

class SocialRegistrationCreateUserErrorState extends SocialRegistrationStates {
  late final String error;
  SocialRegistrationCreateUserErrorState(this.error);
}
