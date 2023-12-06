import 'package:flutter/material.dart';
import '../const/color.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
    required this.buttonText,
    this.onPressed,
  });
  final VoidCallback? onPressed;
  final String buttonText;

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: nextButtonColor,
      ),
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: const TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 35, 35, 35),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
