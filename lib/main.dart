import 'package:edu_diary/config/app_theme.dart';
import 'package:edu_diary/features/menu/presentation/pages/menu.dart';
import 'package:edu_diary/features/performance/presentation/pages/performance.dart';
import 'package:edu_diary/sl.dart';
import 'package:flutter/material.dart';

void main() async {
  await initializeDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(),
      home: const MenuPage()
    );
  }
}
