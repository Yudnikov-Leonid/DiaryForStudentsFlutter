import 'package:edu_diary/config/app_theme.dart';
import 'package:edu_diary/core/service/edu_user.dart';
import 'package:edu_diary/core/service/firebase_push_notifications.dart';
import 'package:edu_diary/features/login/presentation/pages/login.dart';
import 'package:edu_diary/features/menu/presentation/pages/menu.dart';
import 'package:edu_diary/features/news/presentation/pages/news.dart';
import 'package:edu_diary/features/news/presentation/pages/news_details.dart';
import 'package:edu_diary/features/performance/presentation/pages/performance.dart';
import 'package:edu_diary/features/profile/presentation/pages/profile.dart';
import 'package:edu_diary/firebase_options.dart';
import 'package:edu_diary/sl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebasePushNotifications().initNotifications();
  final isLogged = sl<EduUser>().guid().isNotEmpty;

  runApp(MainApp(isLogged));
}

class MainApp extends StatelessWidget {
  final bool isLogged;
  const MainApp(this.isLogged, {super.key});

  @override
  Widget build(BuildContext context) {
    final initialRoute = isLogged ? '/menu' : '/login';
    return MaterialApp(
      title: 'Diary43',
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      theme: theme(),
      routes: {
        '/menu': (context) => const MenuPage(),
        '/login': (context) => LoginPage(),
        '/performance': (context) => const PerformancePage(),
        '/profile': (context) => const ProfilePage(),
        '/news': (context) => const NewsPage(),
        '/news_details': (context) => const NewsDetails()
      },
    );
  }
}
