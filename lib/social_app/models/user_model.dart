class SocialUserModel {
  late String? uId;
  late String name;
  late String? image;
  late String? cover;
  late String phone;
  late String email;
  late String? bio;
  late bool? isEmailVerified;

  SocialUserModel({
    required this.phone,
    required this.name,
    required this.email,
    this.isEmailVerified,
    this.uId,
    this.cover,
    this.image,
    this.bio,
  });

  SocialUserModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    phone = json["phone"];
    uId = json["uId"];
    email = json["email"];
    image = json["image"];
    bio = json["bio"];
    cover = json["cover"];
    isEmailVerified = json["isEmailVerified"];
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "phone": phone,
      "uId": uId,
      "email": email,
      "image": image,
      "cover": cover,
      "bio": bio,
      "isEmailVerified": isEmailVerified,
    };
  }
}
