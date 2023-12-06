import 'package:dart/profiles/custom_widgets/random_color_generator.dart';
import 'package:dart/profiles/custom_widgets/user_info.dart';
import 'package:flutter/material.dart';

/* ================ display round widget of user information ================ */

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({
    super.key,
    required this.name,
    required this.age,
    required this.userBio,
    required this.interests,
  });

  final String name;
  final int age;
  final String userBio;
  final List<String> interests;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: Column(
        children: [
          UserInfoDisplay(
            name: name,
            age: "$age yo",
            userBio: userBio,
            interests: interests,
            personalPrimaryColor: generateRandomLightColor(),
          ),
        ],
      ),
    );
  }
}
