import 'package:face_editor/screens/camera_screen/camera_screen.dart';
import 'package:face_editor/utils/app_strings.dart';
import 'package:face_editor/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppString.appName,
      theme: AppTheme.dark,
      home: const CemeraScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
