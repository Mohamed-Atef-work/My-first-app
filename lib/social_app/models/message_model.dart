class MessageModel {
  late String message;
  late String senderId;
  late String receiverId;
  late String DateTime;

  MessageModel({
    required this.message,
    required this.senderId,
    required this.receiverId,
    required this.DateTime,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    message = json["message"];
    senderId = json["senderId"];
    receiverId = json["receiverId"];
    DateTime = json["DateTime"];
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "senderId": senderId,
      "receiverId": receiverId,
      "DateTime": DateTime,
    };
  }
}
