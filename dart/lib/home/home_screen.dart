import 'package:dart/user/common/const/color.dart';
import 'package:dart/user/common/main_layout.dart';
import 'package:dart/user/common/widget/top_image.dart';
import 'package:dart/user/find_step/email_field.dart';
import 'package:dart/user/find_step/p_number_find_field.dart';
import 'package:dart/user/signin_step/p_numberfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dart/user/login_step/login_screen.dart';


// HomeScreen displays the login and sign-in buttons.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PopScope(
      canPop: false,
      child: MainLayout.purple(
        children: [
          TopImage(), // Display the top image.
          _BottomButton(), // Display the button group at the bottom.
        ],
      ),
    );
  }
}

// _BottomButton contains the login and sign-in buttons.
class _BottomButton extends StatelessWidget {
  const _BottomButton();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        _Button(
          buttonText: 'LOG IN', // Text for the login button.
          onPressed: () {
            Get.to(() => const LogInScreen());
          }, // Route to navigate when the login button is pressed.
          textColor: Colors.white, // Text color for the login button.
          backGroundColor:
              Colors.purple, // Background color for the login button.
        ),
        const SizedBox(
          height: 20.0,
        ),
        _Button(
          buttonText: 'SIGN IN',
          onPressed: () {
            Get.to(() => const PhoneNumberField());
          }, // Route to navigate when the sign-in button is pressed.
          textColor: Colors.purple,
          backGroundColor:
              nextButtonColor, // Background color for the sign-in button.
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 82.0),
          child: Row(
            children: [
              _Find(text: "forgot account?", widget: PhoneNumberFindField()),
              _Find(text: "forgot password?", widget: EmailField()),
            ],
          ),
        )
      ],
    );
  }
}

// _Button represents a custom styled ElevatedButton.
class _Button extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final Color textColor;
  final Color backGroundColor;

  const _Button({
    required this.onPressed,
    required this.buttonText,
    required this.backGroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(
          MediaQuery.of(context).size.width * 2 / 3,
          MediaQuery.of(context).size.width * 1 / 8,
        ),
        foregroundColor: textColor, // Text color for the button.
        backgroundColor: backGroundColor, // Background color for the button.
        textStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 20,
        ),
      ),
      onPressed: onPressed,
      child: Text(buttonText), // Display the button's text.
    );
  }
}

class _Find extends StatelessWidget {
  final String text;
  final Widget widget;

  _Find({required this.text, required this.widget});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(text),
      onPressed: () {
        Get.to(widget);
      },
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
      ),
    );
  }
}
