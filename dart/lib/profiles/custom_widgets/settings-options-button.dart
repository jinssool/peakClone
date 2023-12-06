import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function()? onPressed;
  const SettingsButton(
      {super.key, required this.icon, required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      alignment: Alignment.centerLeft,
      decoration: const BoxDecoration(),
      child: TextButton.icon(
          onPressed: onPressed,
          icon: Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Icon(
              icon,
              size: 32,
              color: Colors.black,
            ),
          ),
          label: Text(
            label,
            style: const TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),
          )),
    );
  }
}
