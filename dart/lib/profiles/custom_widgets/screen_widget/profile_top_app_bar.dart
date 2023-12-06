import 'package:flutter/material.dart';

/* ================ profile top app bar for setting ================ */

class ProfileTopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function() onSettingPressed;

  const ProfileTopAppBar({
    super.key,
    required this.onSettingPressed,
  });

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      title: const Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Text(
              "Peak",
              style: TextStyle(
                  color: Color.fromARGB(255, 81, 54, 255),
                  fontSize: 30,
                  fontWeight: FontWeight.w700),
            ),
            Text(
              "Tew",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
              size: 35,
            ),
            onPressed: () {
              onSettingPressed();
            },
          ),
        ),
      ],
    );
  }
}
