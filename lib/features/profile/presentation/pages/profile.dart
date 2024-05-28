import 'package:edu_diary/core/service/edu_user.dart';
import 'package:edu_diary/features/profile/presentation/widgets/expanded_button.dart';
import 'package:edu_diary/features/profile/presentation/widgets/log_out_button.dart';
import 'package:edu_diary/features/profile/presentation/widgets/top.dart';
import 'package:edu_diary/sl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.blue),
        title: Text(
          locale.your_profile,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        scrolledUnderElevation: 0,
        backgroundColor: const Color.fromARGB(255, 85, 155, 254),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              loginTopWidget(),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    expandedButton(
                        title: locale.email,
                        data: sl<EduUser>().email(),
                        icon: Icons.email),
                    const SizedBox(
                      height: 15,
                    ),
                    expandedButton(
                        title: locale.school,
                        data: sl<EduUser>().school(),
                        icon: Icons.school),
                    const SizedBox(
                      height: 15,
                    ),
                    expandedButton(
                        title: locale.grade, data: sl<EduUser>().grade(), icon: Icons.grade),
                    const SizedBox(
                      height: 15,
                    ),
                    loginLogOutButton(context)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}