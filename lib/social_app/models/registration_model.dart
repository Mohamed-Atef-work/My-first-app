class SocialRegistrationModel {
  late final bool status;
  late final String message;
  late final DataOfUser data;

  SocialRegistrationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = DataOfUser.fromJson(json['data']);
  }
}

class DataOfUser {
  late final String name;
  late final String email;
  late final String phone;
  late final int id;
  late final String image;
  late final String token;

  DataOfUser.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    id = json['id'];
    image = json['image'];
    token = json['token'];
  }
}
