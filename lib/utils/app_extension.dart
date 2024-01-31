import 'package:flutter/material.dart';

extension AppExtensions on Widget {
  GestureDetector asButton({required Function() onTap}) => GestureDetector(
        onTap: onTap,
        child: this,
      );
}
