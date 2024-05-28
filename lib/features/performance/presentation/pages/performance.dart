import 'package:edu_diary/features/performance/presentation/pages/actual_performance.dart';
import 'package:edu_diary/features/performance/presentation/pages/final_performance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class PerformancePage extends StatelessWidget {
  const PerformancePage({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: Text(locale.performance),
                centerTitle: true,
                floating: true,
                pinned: true,
                snap: true,
                backgroundColor: Colors.white,
                bottom: TabBar(tabs: [
                  Tab(
                    text: locale.actual_marks,
                  ),
                  Tab(
                    text: locale.final_marks,
                  )
                ]),
              )
            ];
          },
          body: const TabBarView(
            children: [ActualPerformancePage(), FinalPerformancePage()],
          ),
        ),
      ),
    );
  }
}
