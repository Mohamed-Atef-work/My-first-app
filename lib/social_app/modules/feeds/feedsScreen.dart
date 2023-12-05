import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:my_first_app/shared/components/components.dart';
import 'package:my_first_app/social_app/Cubit/Cubit.dart';
import 'package:my_first_app/social_app/Cubit/States.dart';

import '../../models/post_model.dart';

class SocialFeedsScreen extends StatelessWidget {
  const SocialFeedsScreen({Key? key}) : super(key: key);

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
            condition: SocialCubit.get(context).posts!.isNotEmpty,
            builder: (context) => SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5,
                    margin: EdgeInsets.all(8.0),
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Image.asset(
                          "assets/images/happy-little-girl-celebrating-her-birthday.jpg",
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Communicate with friends",
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                        )
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => BuildPostItem(
                        index: index,
                        context: context,
                        post: SocialCubit.get(context).posts![index]),
                    itemCount: SocialCubit.get(context).posts!.length,
                  )
                ],
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}

Widget BuildPostItem(
        {required context, required PostModel post, required index}) =>
    Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      margin: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                    post.image,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          post.name,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    height: 1.4,
                                  ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.check_circle,
                          size: 16.0,
                        ),
                      ],
                    ),
                    Text(
                      post.dateTime,
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            height: 1.4,
                          ),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_horiz,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 15,
                bottom: 10,
              ),
              child: Container(
                //width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Text(
              post.text,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(
              height: 10,
            ),
            /*Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                runSpacing: 3,
                spacing: 4,
                children: List.generate(
                  7,
                  (index) => InkWell(
                    onTap: () {},
                    child: Text(
                      "#Software",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
            ),*/
            if (post.postImage != "")
              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      post.postImage,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(
                    5.0,
                  ),
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      alignment: Alignment.centerLeft,
                    ),
                    icon: Icon(
                      IconlyBroken.heart,
                      color: Colors.red,
                    ),
                    label: Text("${SocialCubit.get(context).postLikes![index]}",
                        style: Theme.of(context).textTheme.caption),
                  ),
                ),
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      alignment: Alignment.centerRight,
                    ),
                    icon: Icon(
                      IconlyBroken.chat,
                      color: Colors.amber,
                    ),
                    label: Text(
                      "120 comment",
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              //width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      alignment: Alignment.centerLeft,
                    ),
                    icon: CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage(
                        post.image,
                      ),
                    ),
                    label: Text(
                      "write a comment...",
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            height: 1.4,
                          ),
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    SocialCubit.get(context)
                        .likePost(SocialCubit.get(context).postsIds![index]);
                  },
                  style: OutlinedButton.styleFrom(
                    alignment: Alignment.centerLeft,
                  ),
                  icon: Icon(
                    IconlyBroken.heart,
                    color: Colors.red,
                  ),
                  label:
                      Text("Like", style: Theme.of(context).textTheme.caption),
                ),
              ],
            ),
          ],
        ),
      ),
    );
