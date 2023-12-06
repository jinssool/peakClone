import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BasicStruct extends StatelessWidget {
  Widget child;

  BasicStruct({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
    );
  }
}
