import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:my_first_app/shared/components/components.dart';
import 'package:my_first_app/social_app/Cubit/Cubit.dart';
import 'package:my_first_app/social_app/Cubit/States.dart';
import 'package:my_first_app/social_app/models/user_model.dart';

import '../edite_profile/edit_profile.dart';

class SocialSettingsScreen extends StatelessWidget {
  const SocialSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var model = SocialCubit.get(context).socialUserModel;

        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 230,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Image.network(
                          model!.cover!,
                          width: double.infinity,
                          height: 170,
                          fit: BoxFit.cover,
                        ),
                      ),
                      CircleAvatar(
                        radius: 65,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                            model.image!,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  model.name,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                  model.bio!,
                  style: Theme.of(context).textTheme.caption,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            //mainAxisSize: ,
                            children: [
                              Text(
                                "100",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                "posts",
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            //mainAxisSize: ,
                            children: [
                              Text(
                                "100",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                "posts",
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            //mainAxisSize: ,
                            children: [
                              Text(
                                "100",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                "posts",
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            //mainAxisSize: ,
                            children: [
                              Text(
                                "100",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                "posts",
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            //mainAxisSize: ,
                            children: [
                              Text(
                                "100",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                "posts",
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          navigateTo(context, EditProfileScreen());
                        },
                        child: Text("Edit your profile"),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      child: Icon(IconlyBroken.edit),
                    ),
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
