import 'package:dart/profiles/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomBottomNav extends StatelessWidget {
  final void Function(int)? onTabChange;
  const CustomBottomNav({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 25),
      child: GNav(
        onTabChange: (value) => onTabChange!(value),
        tabBackgroundColor: transPrimaryColor,
        color: Colors.grey[600],
        activeColor: primaryColor,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        tabs: const [
          GButton(
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 18),
            icon: Icons.compass_calibration,
            text: "Explore",
            gap: 8,
          ),
          GButton(
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 18),
            icon: Icons.person,
            text: "Profile",
            gap: 8,
          )
        ],
      ),
    );
  }
}
