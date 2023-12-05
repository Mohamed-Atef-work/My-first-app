import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:my_first_app/shared/components/components.dart';
import 'package:my_first_app/social_app/Cubit/Cubit.dart';
import 'package:my_first_app/social_app/Cubit/States.dart';

class SocialNewPostScreen extends StatelessWidget {
  var postController = TextEditingController();
  var now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is UpLoadPostSuccessState) {
          showToast(text: "SUCCESS", state: ToastStates.SUCCESS);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: "Create Post",
            actions: [
              defaultTextButton(
                text: "Post",
                function: () {
                  if (SocialCubit.get(context).postImage == null) {
                    SocialCubit.get(context).upLoadPost(
                      text: postController.text,
                      dateTime: now.toString(),
                    );
                  } else {
                    SocialCubit.get(context).upLoadPostWithImage(
                      text: postController.text,
                      dateTime: now.toString(),
                    );
                  }
                },
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if (state is UpLoadPostImageLoadingState ||
                    state is UpLoadPostLoadingState)
                  LinearProgressIndicator(),
                if (state is UpLoadPostImageLoadingState ||
                    state is UpLoadPostLoadingState)
                  SizedBox(
                    height: 10,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                        SocialCubit.get(context).socialUserModel!.image!,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      SocialCubit.get(context).socialUserModel!.name,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            height: 1.4,
                          ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: postController,
                    decoration: InputDecoration(
                      hintText: "what is on your mind...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (SocialCubit.get(context).postImage != null)
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.file(
                        SocialCubit.get(context).postImage!,
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                      IconButton(
                          onPressed: () {
                            SocialCubit.get(context).removePostImage();
                          },
                          icon: Icon(
                            Icons.close,
                          ))
                    ],
                  ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton.icon(
                        onPressed: () {
                          SocialCubit.get(context).getPostImage();
                        },
                        icon: Icon(IconlyBroken.image),
                        label: Text("  add photo"),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text("# tags"),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
