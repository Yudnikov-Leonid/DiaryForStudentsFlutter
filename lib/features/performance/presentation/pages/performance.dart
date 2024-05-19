import 'package:edu_diary/features/performance/presentation/pages/actual_performance.dart';
import 'package:flutter/material.dart';

class PerformancePage extends StatelessWidget {
  const PerformancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Container(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                const SliverAppBar(
                  title: Text('Performance'),
                  centerTitle: true,
                  floating: true,
                  pinned: true,
                  snap: true,
                  bottom: TabBar(tabs: [
                    Tab(
                      text: 'Actual',
                    ),
                    Tab(
                      text: 'Final',
                    )
                  ]),
                )
              ];
            },
            body: Container(
              child: TabBarView(
                children: [ActualPerformancePage(), Container()],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
