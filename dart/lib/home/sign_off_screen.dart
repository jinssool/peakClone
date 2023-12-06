import 'package:dart/common/local_storage/const.dart';
import 'package:dart/user/common/main_layout.dart';
import 'package:dart/user/common/widget/top_image.dart';
import 'package:flutter/material.dart';

class SignOffScreen extends StatelessWidget{
  const SignOffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: delete(),
        builder: (context, snapshot) {
          if (snapshot.data == true) {
            return const MainLayout.purple(
              children: [
                Expanded(child: TopImage()),
                Expanded(child: SingleChildScrollView(child: _MiddleText(text:"You are successfully signed off!"))),

              ],
            );} else {
            return const MainLayout.purple(
              children: [
                Expanded(child: TopImage()),
                Expanded(child: SingleChildScrollView(child: _MiddleText( text: "Loading..."))),
                Expanded(child: _BottomCircleProgressBar()),
              ],
            );
            }
          });
  }
}
Future<bool> delete() async {
  await storage.deleteAll();
  Map<String,String> allValues = await storage.readAll();
  if(allValues.isEmpty){
    return true;
  } else {
    return false;
  }
}
class _BottomCircleProgressBar extends StatelessWidget {
  const _BottomCircleProgressBar();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 70,
          width: 70,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 10,
          ),
        ),
      ],
    );
  }
}

class _MiddleText extends StatelessWidget {
  final String text;

  const _MiddleText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 40),
          ),
        ),
      ],
    );
  }
}
