import 'package:flutter/material.dart';
import 'const/color.dart';

class CustomTextFormField extends StatelessWidget {
  final bool hasError;
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final double height;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Widget? suffixWiget;

  // Constructor for a login-style form field
  const CustomTextFormField.log({
    super.key,
    required this.hasError,
    required this.onChanged,
    this.autofocus = false,
    this.obscureText = false,
    this.hintText,
    this.errorText,
    this.validator,
    this.focusNode,
    this.keyboardType,
    this.height = 90,
    this.controller,
    this.suffixWiget,
  });
/* test for merge*/
  // Constructor for a signup-style form field
  const CustomTextFormField.sign({
    super.key,
    required this.hasError,
    this.autofocus = false,
    this.obscureText = false,
    this.hintText,
    this.errorText,
    this.validator,
    this.focusNode,
    this.keyboardType,
    this.height = 60,
    this.controller,
    this.suffixWiget,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderSide: const BorderSide(
        color: nextButtonColor,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(10),
    );

    double boxHeight = hasError ? height + 20 : height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: !hasError
              ? const [
                  BoxShadow(
                    color: textColor,
                    offset: Offset(0, 0),
                    blurRadius: 10,
                    blurStyle: BlurStyle.outer,
                  ),
                ]
              : null,
        ),
        width: MediaQuery.of(context).size.width,
        height: boxHeight,
        child: TextFormField(
          style: const TextStyle(fontSize: 20.0),
          keyboardType: keyboardType,
          enableSuggestions: true,
          validator: validator,
          focusNode: focusNode,
          textAlign: TextAlign.center,
          cursorHeight: 20,
          cursorColor: textColor,
          obscureText: obscureText,
          onChanged: onChanged,
          autofocus: autofocus,
          controller: controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
            hintText: hintText,
            errorText: errorText,
            errorStyle: const TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
            hintStyle: const TextStyle(
              color: textColor,
              fontSize: 20.0,
            ),
            fillColor: Colors.white,
            filled: true,
            border: baseBorder,
            enabledBorder: baseBorder,
            focusedBorder: baseBorder.copyWith(
              borderSide: baseBorder.borderSide.copyWith(
                width: 2,
                color: const Color.fromARGB(255, 177, 81, 250),
              ),
            ),
            suffixIcon: suffixWiget,
          ),
        ),
      ),
    );
  }
}
