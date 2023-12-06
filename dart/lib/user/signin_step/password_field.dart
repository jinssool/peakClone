import 'package:dart/common/local_storage/const.dart';
import 'package:dart/user/login_step/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/api/request.dart';
import '../common/custom_textform.dart';
import '../../common/api/route_address.dart';
import '../common/widget/next_button.dart';
import '../common/const/color.dart';
import '../common/main_layout.dart';
import '../common/widget/top_text.dart';
import '../../user/common/regular_expression.dart';

class PasswordField extends StatefulWidget {
  final TextStyle textstyle = const TextStyle(
    color: textColor,
    fontSize: 50,
    fontWeight: FontWeight.bold,
  );

  const PasswordField({
    super.key,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  String password = '';
  String confirmPassword = '';
  String? errorText;
  bool isMatched = false;
  String id = '';
  final dio = Dio();
  List<String> userData = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _passwordFocusNode = FocusNode();
  bool hasError = false;
  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isOnKeyBoard = MediaQuery.of(context).viewInsets.bottom == 0;
    TextStyle textstyle = const TextStyle(
      color: textColor,
      // fontSize: isOnKeyBoard ? 45 : 30,
      fontSize: 45,
      fontWeight: FontWeight.bold,
    );
    return MainLayout.white(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 50,
            left: 15,
            right: 15,
          ),
          child: TopText(
            children: [
              Text(
                "Enter your",
                style: textstyle,
              ),
              Text(
                "Password",
                style: textstyle,
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Create a robust password for your account to enhance its security.",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Color.fromARGB(255, 66, 66, 66)),
              ),
            ],
          ),
        ),
        Form(
          key: _formKey,
          child: _Bottom(
            errorText: errorText,
            keyboardOn: isOnKeyBoard,
            hasError: hasError,
            passwordFocusNode: _passwordFocusNode,
            onChanged: onChanged,
            onConfirmChanged: onConfirmChanged,
            signin: validInputCheck,
            isMatched: isMatched,
          ),
        ),
      ],
    );
  }

  /* -------------------- methods ------------------- */

  // Perform the login request.
  void signin() async {
    final signin = PreApiService();
    final phoneNumber = await storage.read(key: phoneNumberLS);
    final userName = await storage.read(key: nickLS);
    final birthday = await storage.read(key: birthdayLS);
    final response = await signin.request(
      '$phoneNumber:$userName:$birthday:$password',
      signUpURL,
    );
    final message = await signin.reponseMessageCheck(response);

    if (message == 'success') {
      nextPage();
    } else {
      setState(() {
        errorText = message;
        hasError = true;
      });
    }
  }

  // Navigate to the next screen.
  void nextPage() {
    Get.off(const LogInScreen());
  }

  // Called when the input field value changes.
  void onChanged(String val) {
    if (_formKey.currentState!.validate()) {
      hasError = false;
      errorText = null;
    } else {
      hasError = true;
    }
    setState(() {
      password = val;
    });
  }

// To check if password and confirm password is matching or not
  void onConfirmChanged(String val) {
    setState(() {
      confirmPassword = val;
    });
    if (confirmPassword != password) {
      setState(() {
        isMatched = false;
      });
    } else {
      setState(() {
        isMatched = true;
      });
    }
    print("Is password Matched?: $isMatched --------------");
  }

  // Validate the input and proceed accordingly.
  void validInputCheck() {
    if (_formKey.currentState!.validate()) {
      signin(); // Perform login.
    } else {
      setState(() {}); // Refresh the UI to show validation errors.
    }
  }

  /* -------------------- methods ------------------- */
}

class _Bottom extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onConfirmChanged;
  final VoidCallback signin;
  final FocusNode passwordFocusNode;
  final bool hasError;
  final bool keyboardOn;

  final String? errorText;
  final bool isMatched;
  const _Bottom({
    required this.keyboardOn,
    required this.errorText,
    required this.hasError,
    required this.onChanged,
    required this.onConfirmChanged,
    required this.signin,
    required this.passwordFocusNode,
    required this.isMatched,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextFormField.sign(
            errorText: errorText,
            hasError: hasError,

            focusNode: passwordFocusNode,
            validator: (value) => value?.validatePassword(
                passwordFocusNode, value), // Password validation.
            hintText: 'Password', // Placeholder text for input

            obscureText: true,
            onChanged: onChanged, // Called when input value changes.
            autofocus: true,
          ),
          const SizedBox(
            // height: keyboardOn ? 30.0 : 5.0,
            height: 20,
          ),
          CustomTextFormField.sign(
            hasError: hasError,
            onChanged: onConfirmChanged,
            hintText: "Confirm your password",
            obscureText: true,
          ),
          const SizedBox(height: 15),
          NextButton(
            buttonText: 'COMPLETE', // Text for the button.
            onPressed:
                isMatched ? signin : null, // Called when the button is pressed.
          ),
        ],
      ),
    );
  }
}
