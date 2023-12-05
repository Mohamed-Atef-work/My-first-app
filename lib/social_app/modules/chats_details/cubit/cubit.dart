import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/social_app/models/message_model.dart';
import 'package:my_first_app/social_app/modules/chats_details/cubit/states.dart';

class ChatsDetailsCubit extends Cubit<ChatsDetailsStates> {
  ChatsDetailsCubit() : super(ChatsDetailsInitialState());

  static ChatsDetailsCubit get(context) => BlocProvider.of(context);

  var firebase = FirebaseFirestore.instance;

  MessageModel? messageModel;

  void sendMessages({
    required String message,
    required String senderId,
    required String receiverId,
  }) {
    messageModel = MessageModel(
      message: message,
      senderId: senderId,
      receiverId: receiverId,
      DateTime: DateTime.now().toString(),
    );

    firebase
        .collection("user")
        .doc(senderId)
        .collection("chats")
        .doc(receiverId)
        .collection("messages")
        .add(messageModel!.toJson())
        .then((value) {
      emit(ChatsDetailsSendMessageSuccessState());
    }).catchError((error) {
      emit(ChatsDetailsSendMessageErrorState());
    });

    firebase
        .collection("user")
        .doc(receiverId)
        .collection("chats")
        .doc(senderId)
        .collection("messages")
        .add(messageModel!.toJson())
        .then((value) {
      emit(ChatsDetailsSendMessageSuccessState());
    }).catchError((error) {
      emit(ChatsDetailsSendMessageErrorState());
    });
  }

  List<MessageModel>? messages = [];

  void getAllMessages({
    required String senderId,
    required String receiverId,
  }) {
    firebase
        .collection("user")
        .doc(senderId)
        .collection("chats")
        .doc(receiverId)
        .collection("messages")
        .orderBy("DateTime")
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages!.add(MessageModel.fromJson(element.data()));
      });
      emit(ChatsDetailsGetMessageSuccessState());
    });

    //print("Message is ------------> ${messages[0].message}");
  }
}
