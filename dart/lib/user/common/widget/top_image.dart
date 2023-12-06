import 'package:flutter/widgets.dart';

class TopImage extends StatelessWidget {
  const TopImage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isOnKeyBoard = MediaQuery.of(context).viewInsets.bottom == 0;
    return Image.asset(
      'assets/img/logo/peaktew_logo.png',
      fit: BoxFit.contain,
      width: isOnKeyBoard
          ? MediaQuery.of(context).size.width * 1 / 2
          : MediaQuery.of(context).size.width * 1 / 3,
    );
  }
}
