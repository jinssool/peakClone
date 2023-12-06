import 'package:dart/profiles/custom_widgets/hobbies_tile.dart';
import 'package:dart/profiles/custom_widgets/random_color_generator.dart';
import 'package:flutter/material.dart';

class UserInfoDisplay extends StatelessWidget {
  final String name;
  final String userBio;
  final String age;

  final List<String> interests;
  final Color personalPrimaryColor;
  const UserInfoDisplay({
    super.key,
    required this.name,
    required this.age,
    required this.userBio,
    required this.interests,
    required this.personalPrimaryColor,
  });

  @override
  Widget build(BuildContext context) {
    Color nameTextColor = checkColorContrast(personalPrimaryColor);
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          IntrinsicWidth(
            child: Container(
              width: null,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                  color: personalPrimaryColor,
                  border: Border.all(
                      width: .75, color: const Color.fromARGB(255, 40, 40, 40)),
                  borderRadius: BorderRadius.circular(25)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        color: nameTextColor,
                        fontSize: 23,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 15,
                    child: Text(
                      ",",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                        color: nameTextColor,
                      ),
                    ),
                  ),
                  Text(
                    age,
                    style: TextStyle(
                      color: nameTextColor,
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const SizedBox(height: 15),
          Text(
            userBio,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          Text(
            "Interests:",
            style: TextStyle(
              color: nameTextColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 15),
          Wrap(
            spacing: 8.0, // horizontal spacing between items
            runSpacing: 8.0, // vertical spacing between lines
            children: interests.map((interest) {
              return HobbiesTile(name: interest);
            }).toList(),
          ),
        ],
      ),
    );
  }
}

String getGenderFromInt(int value) {
  if (value == 0) {
    return "Male";
  } else if (value == 1) {
    return "Female";
  } else {
    return "Unspecified";
  }
}
