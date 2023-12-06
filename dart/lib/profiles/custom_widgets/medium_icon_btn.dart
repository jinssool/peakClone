import 'package:flutter/material.dart';

class RoundedMedIconBtn extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Icon icon;
  const RoundedMedIconBtn({
    super.key,
    required this.title,
    required this.onPressed,
    required this.backgroundColor,
    required this.icon,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: TextButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(13.0),
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
