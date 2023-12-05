class RegistrationErrorModel {
  late final bool status;
  late final String message;
  late final Null data;

  RegistrationErrorModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = null;
  }
}
