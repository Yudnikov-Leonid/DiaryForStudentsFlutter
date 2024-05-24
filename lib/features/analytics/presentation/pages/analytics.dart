import 'package:edu_diary/features/analytics/presentation/bloc/analytics_bloc.dart';
import 'package:edu_diary/features/analytics/presentation/bloc/analytics_event.dart';
import 'package:edu_diary/features/analytics/presentation/bloc/analytics_state.dart';
import 'package:edu_diary/features/analytics/presentation/widgets/line_chart.dart';
import 'package:edu_diary/sl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AnalyticsBloc>(
        create: (context) => sl()..add(LoadAnalyticsEvent()),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Analytics'),
            centerTitle: true,
          ),
          body: BlocBuilder<AnalyticsBloc, AnalyticsState>(
            builder: (context, state) {
              if (state is AnalyticsLoadedState) {
                return SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        DropdownButton(
                          items: const [
                            DropdownMenuItem<int>(
                                value: 1, child: Text('First quarter')),
                            DropdownMenuItem<int>(
                                value: 2, child: Text('Second quarter')),
                            DropdownMenuItem<int>(
                                value: 3, child: Text('Third quarter')),
                            DropdownMenuItem<int>(
                                value: 4, child: Text('Fourth quarter')),
                            DropdownMenuItem<int>(
                                value: 5, child: Text('Year')),
                          ],
                          onChanged: (value) {},
                          value: 1,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          'Average progress',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        MarksLineChart(state.averageProgress.data,
                            state.averageProgress.labels),
                      ],
                    ),
                  ),
                );
              } else if (state is AnalyticsFailState) {
                return Center(child: Text(state.message));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ));
  }
}
