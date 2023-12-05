class ProfileModel {
  late final bool status;
  late final Null message;
  late final DataOfProfile data;

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = null;
    data = DataOfProfile.fromJson(json['data']);
  }
}

class DataOfProfile {
  late final int id;
  late final String name;
  late final String email;
  late final String phone;
  late final String image;
  late final int points;
  late final int credit;
  late final String token;

  DataOfProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}
