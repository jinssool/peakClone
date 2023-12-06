import 'package:flutter/material.dart';

class RoundedLargeIconBtn extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final String image;
  const RoundedLargeIconBtn({
    super.key,
    required this.title,
    required this.onPressed,
    required this.backgroundColor,
    required this.image,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
        onPressed: onPressed,
        icon: Image.asset(
          image,
          height: 27,
        ),
        label: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 17,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
