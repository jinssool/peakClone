import 'package:flutter/material.dart';

import 'const/color.dart';

class MainLayout extends StatelessWidget {
  final List<Widget> children;
  final Color backGroundColor;
  final FloatingActionButton? floatingActionButton;
  // Constructor for a white background layout
  const MainLayout.white({
    super.key,
    required this.children,
    this.floatingActionButton,
  }) : backGroundColor = Colors.white;

  // Constructor for a purple background layout
  const MainLayout.purple({
    super.key,
    this.floatingActionButton,
    required this.children,
  }) : backGroundColor = textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        floatingActionButton: floatingActionButton,
        backgroundColor: backGroundColor,
        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}
