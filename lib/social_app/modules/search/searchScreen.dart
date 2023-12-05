import 'package:flutter/material.dart';

class SocialSearchScreen extends StatelessWidget {
  const SocialSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Center(
        child: Text(
          "SocialSearchScreen",
        ),
      ),
    );
  }
}
