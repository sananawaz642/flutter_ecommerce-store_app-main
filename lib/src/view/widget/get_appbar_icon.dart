import 'package:flutter/material.dart';

import '../../../core/app_color.dart';

class AppBarIcon extends StatelessWidget {
  const AppBarIcon({super.key, required  this.icon, required this.onPress});
  final IconData icon;
  final void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.lightGrey,
      ),
      child: IconButton(
        padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(),
        onPressed: onPress,
        icon: Icon(icon, color: Colors.black),
      ),
    );
  }
}