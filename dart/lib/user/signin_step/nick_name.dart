import 'package:dart/common/local_storage/const.dart';
import 'package:dart/user/signin_step/age_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/widget/input_next_button.dart';
import '../common/const/color.dart';
import '../common/main_layout.dart';
import '../../user/common/regular_expression.dart';

class NameField extends StatefulWidget {
  const NameField({
    super.key,
  });

  @override
  State<NameField> createState() => _NameFieldState();
}

class _NameFieldState extends State<NameField> {
  String username = '';
  bool hasError = false;
  final _nameFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameFocusNode.dispose();
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
            left: 15,
            right: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "What's your",
                style: textstyle,
              ),
              Text(
                "Nick Name?",
                style: textstyle,
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Please enter your desired username for your new account.",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Color.fromARGB(255, 66, 66, 66)),
              )
            ],
          ),
        ),
        Form(
          key: _formKey,
          child: BottomField(
            keyboardOn: isOnKeyBoard,
            hasError: hasError,
            validator: (value) =>
                value?.validateNickName(_nameFocusNode, value),
            buttonText: 'NEXT', // Text for the button.
            onChanged: onChanged, // Called when input value changes.
            hintText: 'nickname', // Placeholder text for input.
            onPressed: validInputCheck, // Called when the button is pressed.
          ),
        ),
      ],
    );
  }

  /* -------------------- methods ------------------- */

  // Called when the input field value changes.
  void onChanged(String val) {
    if (_formKey.currentState!.validate()) {
      hasError = false;
    } else {
      hasError = true;
    }
    setState(() {
      username = val;
    });
  }

  // Navigate to the next screen with the collected data.
  void nextPage() {
    Get.to(const AgeField());
  }

  // Check if the form input is valid and proceed accordingly.
  void validInputCheck() async {
    if (_formKey.currentState!.validate()) {
      await storage.write(key: nickLS, value: username);
      nextPage(); // Proceed to the next screen.
    } else {
      setState(() {}); // Refresh the UI to show validation errors.
    }
  }
  /* -------------------- methods ------------------- */
}
