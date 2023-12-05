class PostModel {
  late String uId;
  late String name;
  late String postImage;
  late String image;
  late String text;
  late String dateTime;

  PostModel({
    required this.image,
    required this.name,
    required this.uId,
    required this.text,
    required this.dateTime,
    required this.postImage,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    image = json["image"];
    uId = json["uId"];
    dateTime = json["dateTime"];
    postImage = json["postImage"];
    text = json["text"];
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "image": image,
      "uId": uId,
      "dateTime": dateTime,
      "postImage": postImage,
      "text": text,
    };
  }
}
