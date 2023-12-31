// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../constants/colors/app_color.dart';

class LogInElevatodButton extends StatelessWidget {
  const LogInElevatodButton(
      {super.key, required this.text, required this.onTap});
  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          onTap();
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: AppConstantsColor.materialThemeColor,
          backgroundColor: AppConstantsColor.lightTextColor,
          minimumSize: const Size.fromHeight(50), // NEW
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ));
  }
}
