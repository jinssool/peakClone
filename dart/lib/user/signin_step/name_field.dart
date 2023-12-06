import 'package:dart/common/local_storage/const.dart';
import 'package:dart/user/common/custom_textform.dart';
import 'package:dart/user/common/widget/next_button.dart';
import 'package:dart/user/signin_step/age_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  String firstName = '';
  String lastName = '';
  bool hasError = false;
  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final GlobalKey<FormState> _formKeyFirst = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyLast = GlobalKey<FormState>();
  @override
  void dispose() {
    _firstNameFocusNode.dispose();
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
                "Name?",
                style: textstyle,
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Please enter your name for your new account.",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Color.fromARGB(255, 66, 66, 66)),
              )
            ],
          ),
        ),
        Form(
          key: _formKeyFirst,
          child: CustomTextFormField.sign(
            hasError: hasError,
            hintText: 'first name',
            onChanged: onChangedFirst,
            autofocus: true,
            errorText: null,
            validator: (value) =>
                value?.validateName(_firstNameFocusNode, value),
            keyboardType: TextInputType.name,
          ),
        ),
        Form(
          key: _formKeyLast,
          child: CustomTextFormField.sign(
            hasError: hasError,
            hintText: 'last name',
            onChanged: onChangedLast,
            autofocus: true,
            errorText: null,
            validator: (value) =>
                value?.validateName(_lastNameFocusNode, value),
            keyboardType: TextInputType.name,
          ),
        ),
        const SizedBox(
          // height: keyboardOn ? 20.0 : 10.0,
          height: 15,
        ),
        NextButton(
          buttonText: 'NEXT',
          onPressed: validInputCheck,
        ),
      ],
    );
  }

  /* -------------------- methods ------------------- */

  // Called when the input field value changes.
  void onChangedFirst(String val) {
    if (_formKeyFirst.currentState!.validate()) {
      hasError = false;
    } else {
      hasError = true;
    }
    setState(() {
      firstName = val;
    });
  }

  void onChangedLast(String val) {
    if (_formKeyLast.currentState!.validate()) {
      hasError = false;
    } else {
      hasError = true;
    }
    setState(() {
      lastName = val;
    });
  }

  // Navigate to the next screen with the collected data.
  void nextPage() {
    Get.to(const AgeField());
  }

  // Check if the form input is valid and proceed accordingly.
  void validInputCheck() async {
    if (_formKeyLast.currentState!.validate() &&
        _formKeyFirst.currentState!.validate()) {
      await storage.write(key: firstNameLS, value: firstName);
      await storage.write(key: lastNameLS, value: lastName);
      nextPage(); // Proceed to the next screen.
    } else {
      setState(() {}); // Refresh the UI to show validation errors.
    }
  }

  /* -------------------- methods ------------------- */
}
