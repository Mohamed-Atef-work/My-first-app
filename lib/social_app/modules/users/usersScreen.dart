import 'package:flutter/material.dart';

class SocialUsersScreen extends StatelessWidget {
  const SocialUsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Center(
        child: Text(
          "SocialUsersScreen",
        ),
      ),
    );
  }
}
