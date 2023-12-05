import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/shared/components/components.dart';
import 'package:my_first_app/social_app/Cubit/Cubit.dart';
import 'package:my_first_app/social_app/Cubit/States.dart';
import 'package:my_first_app/social_app/models/user_model.dart';
import 'package:my_first_app/social_app/modules/chats_details/chatsDetailsScreen.dart';

class SocialChatsScreen extends StatelessWidget {
  const SocialChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
          ),
          body: ConditionalBuilder(
            condition: SocialCubit.get(context).users!.isNotEmpty,
            builder: (BuildContext context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildChatItem(
                  context: context,
                  userModel: SocialCubit.get(context).users![index]),
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey,
                height: 2,
                thickness: 2,
                indent: 5,
                endIndent: 5,
              ),
              itemCount: SocialCubit.get(context).users!.length,
            ),
            fallback: (BuildContext context) =>
                Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}

Widget buildChatItem({
  required context,
  required SocialUserModel userModel,
}) =>
    InkWell(
      onTap: () {
        navigateTo(
            context,
            ChatsDetailsScreen(
              socialChatWithModel: userModel,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                userModel.image!,
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              userModel.name,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    height: 1.4,
                  ),
            ),
          ],
        ),
      ),
    );
