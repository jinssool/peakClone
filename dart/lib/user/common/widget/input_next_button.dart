import 'package:flutter/material.dart';
import '../custom_textform.dart';
import 'next_button.dart';

class BottomField extends StatelessWidget {
  final String hintText;
  final String? errorText;
  final String buttonText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onPressed;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool hasError;
  final bool keyboardOn;
  const BottomField({
    super.key,
    required this.keyboardOn,
    required this.hintText,
    this.onChanged,
    required this.buttonText,
    required this.onPressed,
    required this.hasError,
    this.validator,
    this.keyboardType,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextFormField.sign(
            hasError: hasError,
            hintText: hintText,
            onChanged: onChanged,
            autofocus: true,
            errorText: errorText,
            validator: validator,
            keyboardType: keyboardType,
          ),
          const SizedBox(

            // height: keyboardOn ? 20.0 : 10.0,
            height: 15,
          ),
          NextButton(
            buttonText: buttonText,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
