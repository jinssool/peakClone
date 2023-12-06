import 'package:flutter/material.dart';

class LargeBtn extends StatelessWidget {
  final Color color;

  final String text;
  const LargeBtn({
    super.key,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        text,
      ),
    );
  }
}
