import 'package:dart/profiles/custom_widgets/random_color_generator.dart';
import 'package:flutter/material.dart';

class HobbiesTile extends StatelessWidget {
  final String name;
  const HobbiesTile({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    Color randomColor = generateRandomLightColor();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      decoration: BoxDecoration(
        color: randomColor,
        borderRadius: BorderRadiusDirectional.circular(20),
        border:
            Border.all(width: .6, color: const Color.fromARGB(255, 40, 40, 40)),
      ),
      child: Text(
        name,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}
