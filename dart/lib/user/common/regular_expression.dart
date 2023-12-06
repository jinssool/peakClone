import 'package:flutter/material.dart';

extension InputValidate on String {
  /* ---------------------- validation for email  ----------------------*/
  String? validateEmail(FocusNode focusNode, String value) {
    if (value.isEmpty) {
      focusNode.requestFocus();
      return 'Put your Email.';
    } else {
      String pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = RegExp(pattern);

      if (!regExp.hasMatch(value)) {
        focusNode.requestFocus(); // focusing on this.textformfield

        if (value.contains(' ')) {
          return 'Email should not contain spaces';
        } else if (!value.contains('@')) {
          return 'Email should contain @ symbol';
        } else if (value.startsWith('@') || value.endsWith('@')) {
          return 'Invalid position of @ symbol';
        } else if (value.split('@')[1].contains('.') == false) {
          return 'Email should contain at least one dot after @';
        } else {
          return 'Invalid Email format';
        }
      } else {
        return null;
      }
    }
  }

/* ---------------------- validation for phone Number ---------------------- */
  String? validatePhoneNumber(FocusNode focusNode, String value) {
    if (value.isEmpty) {
      focusNode.requestFocus();
      return 'Put your Phone Number.';
    } else {
      String patternKR = r'^01(0|1|6|7|8|9)-?([0-9]{3,4})-?([0-9]{4})$';
      String patternUS = r'^\d{3}-\d{3}-\d{4}$';
      String patternJP = r'^\d{2,4}-\d{2,4}-\d{3,4}$';

      RegExp regExpKR = RegExp(patternKR);
      RegExp regExpUS = RegExp(patternUS);
      RegExp regExpJP = RegExp(patternJP);

      if (!regExpKR.hasMatch(value) &&
          !regExpUS.hasMatch(value) &&
          !regExpJP.hasMatch(value)) {
        focusNode.requestFocus(); // focusing on this textformfield
        return 'Invalid Phone Number format';
      }

      if (regExpKR.hasMatch(value)) {
        return validatePhoneNumberKR(value);
      } else if (regExpUS.hasMatch(value)) {
        return validatePhoneNumberUS(value);
      } else if (regExpJP.hasMatch(value)) {
        return validatePhoneNumberJP(value);
      }

      return null; // Phone Number is valid
    }
  }

  String? validatePhoneNumberKR(String value) {
    // Additional validation specific to South Korea
    String patternKR = r'^01(0|1|6|7|8|9)-?([0-9]{3,4})-?([0-9]{4})$';
    RegExp regExpKR = RegExp(patternKR);

    if (!regExpKR.hasMatch(value)) {
      return 'Invalid Korean Phone Number format';
    }

    // You can add more specific rules here for the Korean format
    // For example, checking the area code, etc.

    return null; // If it's a valid Korean phone number
  }

  String? validatePhoneNumberUS(String value) {
    // Additional validation specific to the United States
    String patternUS = r'^\d{3}-\d{3}-\d{4}$';
    RegExp regExpUS = RegExp(patternUS);

    if (!regExpUS.hasMatch(value)) {
      return 'Invalid US Phone Number format';
    }

    // You can add more specific rules here for the US format
    // For example, checking the area code, etc.

    return null; // If it's a valid US phone number
  }

  String? validatePhoneNumberJP(String value) {
    // Additional validation specific to Japan
    String patternJP = r'^\d{2,4}-\d{2,4}-\d{3,4}$';
    RegExp regExpJP = RegExp(patternJP);

    if (!regExpJP.hasMatch(value)) {
      return 'Invalid Japanese Phone Number format';
    }

    // You can add more specific rules here for the Japanese format
    // For example, checking the area code, etc.

    return null; // If it's a valid Japanese phone number
  }

/* ---------------------- validation for password ---------------------- */
  String? validatePassword(FocusNode focusNode, String value) {
    if (value.isEmpty) {
      focusNode.requestFocus();
      return 'Put your password';
    }

    // Check length
    if (value.length < 8 || value.length > 15) {
      focusNode.requestFocus();
      return 'must be between 8 and 15 characters';
    }

    // Check for special characters
    if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value)) {
      focusNode.requestFocus();
      return 'contain at least one special character';
    }

    // Check for uppercase letters
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      focusNode.requestFocus();
      return 'contain at least one uppercase letter';
    }

    // Check for lowercase letters
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      focusNode.requestFocus();
      return 'contain at least one lowercase letter';
    }

    // Check for numbers
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      focusNode.requestFocus();
      return ' must contain at least one number';
    }

    return null; // Password is valid
  }

/* ---------------------- validation for name or username ----------------------*/
  String? validateNickName(FocusNode focusNode, String value) {
    if (value.isEmpty) {
      focusNode.requestFocus();
      return 'Put your nick name';
    }

    // Check length
    if (value.length < 4 || value.length > 20) {
      focusNode.requestFocus();
      return 'must be between 4 and 20 characters';
    }

    // Check for allowed characters (letters and digits)
    if (!RegExp(r'^[A-Za-z]+$').hasMatch(value)) {
      focusNode.requestFocus();
      return 'Name can only contain letters and digits';
    }

    return null; // Name is valid
  }

  String? validateName(FocusNode focusNode, String value) {
    if (value.isEmpty) {
      focusNode.requestFocus();
      return 'Put your name';
    }

    // Check length
    if (value.isEmpty || value.length > 20) {
      focusNode.requestFocus();
      return 'must be between 4 and 20 characters';
    }

    // Check first letter
    if (!RegExp(r'[A-Za-z]').hasMatch(value[0])) {
      focusNode.requestFocus();
      return 'Name must start with a letter';
    }

    // Check for allowed characters (letters and digits)
    if (!RegExp(r'^[A-Za-z\d]+$').hasMatch(value)) {
      focusNode.requestFocus();
      return 'Name can only contain letters and digits';
    }

    return null; // Name is valid
  }

/* ---------------------- validation for age ---------------------- */
  String? validateAge(FocusNode focusNode, String value) {
    if (value.isEmpty) {
      focusNode.requestFocus();
      return 'Put your age';
    } else {
      String pattern = r'^[0-9]{1,3}$';
      RegExp regExp = RegExp(pattern);

      if (!regExp.hasMatch(value)) {
        focusNode.requestFocus();
        return 'Age must be between 1 and 3 digits';
      }

      int? age = int.tryParse(value);

      if (age == null || age < 16 || age > 100) {
        focusNode.requestFocus();
        return 'Age must be between 16 and 100';
      }

      return null;
    }
  }
}
