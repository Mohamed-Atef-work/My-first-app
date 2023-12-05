import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:my_first_app/shared/components/components.dart';
import 'package:my_first_app/social_app/Cubit/Cubit.dart';
import 'package:my_first_app/social_app/Cubit/States.dart';

import '../modules/new_post/new_post_screen.dart';

class SocialLayout extends StatelessWidget {
  SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = SocialCubit.get(context);

    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, states) {
        if (states is SocialNewPostState) {
          navigateTo(
            context,
            SocialNewPostScreen(),
          );
        }
      },
      builder: (context, states) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  IconlyBroken.notification,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  IconlyBroken.search,
                ),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(
                label: "Home",
                icon: Icon(
                  IconlyBroken.home,
                ),
              ),
              BottomNavigationBarItem(
                label: "Chats",
                icon: Icon(
                  IconlyBroken.chat,
                ),
              ),
              BottomNavigationBarItem(
                label: "Post",
                icon: Icon(
                  IconlyBroken.upload,
                ),
              ),
              BottomNavigationBarItem(
                label: "Users",
                icon: Icon(
                  IconlyBroken.location,
                ),
              ),
              BottomNavigationBarItem(
                label: "Setting",
                icon: Icon(
                  IconlyBroken.setting,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/*ConditionalBuilder(
            condition: SocialCubit.get(context).socialUserModel != null,
            builder: (context) {
              var socialModelIsVerified =
                  FirebaseAuth.instance.currentUser!.emailVerified;

              return Column(
                children: [
                  if (socialModelIsVerified == false)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      color: Colors.amber.withOpacity(0.6),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text("Pleas verify your email"),
                          Spacer(),
                          defaultTextButton(
                            text: "SEND",
                            function: () {
                              FirebaseAuth.instance.currentUser!
                                  .sendEmailVerification()
                                  .then((value) {
                                showToast(
                                    text: "Check your mail",
                                    state: ToastStates.SUCCESS);
                              }).catchError((error) {});
                            },
                          )
                        ],
                      ),
                    ),
                ],
              );
            },
            fallback: (context) => Center(child: CircularProgressIndicator()),
          )*/
