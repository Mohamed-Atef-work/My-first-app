import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../../Cubit/Cubit.dart';
import '../../models/message_model.dart';
import '../../models/user_model.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ChatsDetailsScreen extends StatelessWidget {
  SocialUserModel socialChatWithModel;

  ChatsDetailsScreen({required this.socialChatWithModel});

  var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ChatsDetailsCubit()
        ..getAllMessages(
            senderId: SocialCubit.get(context).socialUserModel!.uId!,
            receiverId: socialChatWithModel.uId!),
      child: BlocConsumer<ChatsDetailsCubit, ChatsDetailsStates>(
        listener: (context, state) {
          if (state is ChatsDetailsSendMessageSuccessState) {
            controller.text = "";
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 70,
              title: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 5,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                        socialChatWithModel.image!,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      socialChatWithModel.name,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            height: 1.4,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ConditionalBuilder(
                      condition:
                          ChatsDetailsCubit.get(context).messages != null,
                      builder: (context) => ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (ChatsDetailsCubit.get(context)
                                  .messages![index]
                                  .receiverId ==
                              socialChatWithModel.uId)
                            return buildMyMessage(
                              ChatsDetailsCubit.get(context).messages![index],
                            );
                          return buildMessage(
                            ChatsDetailsCubit.get(context).messages![index],
                          );
                        },
                        itemCount:
                            ChatsDetailsCubit.get(context).messages!.length,
                      ),
                      fallback: (context) =>
                          Center(child: CircularProgressIndicator()),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "write your message ....",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          controller: controller,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        child: CircleAvatar(
                          radius: 25,
                          child: IconButton(
                            onPressed: () {
                              ChatsDetailsCubit.get(context).sendMessages(
                                message: controller.text,
                                senderId: SocialCubit.get(context)
                                    .socialUserModel!
                                    .uId!,
                                receiverId: socialChatWithModel.uId!,
                              );
                            },
                            icon: Icon(IconlyBroken.send),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buildMessage(MessageModel message) => Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
            ),
          ),
          child: Text(
            message.message,
          ),
        ),
      ),
    );

Widget buildMyMessage(MessageModel message) => Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.2),
            borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
              bottomStart: Radius.circular(10.0),
            ),
          ),
          child: Text(
            message.message,
          ),
        ),
      ),
    );
