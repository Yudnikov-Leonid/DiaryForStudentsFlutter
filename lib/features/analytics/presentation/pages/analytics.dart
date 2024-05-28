import 'package:edu_diary/features/analytics/presentation/bloc/analytics_bloc.dart';
import 'package:edu_diary/features/analytics/presentation/bloc/analytics_event.dart';
import 'package:edu_diary/features/analytics/presentation/bloc/analytics_state.dart';
import 'package:edu_diary/features/analytics/presentation/widgets/line_chart.dart';
import 'package:edu_diary/features/analytics/presentation/widgets/multi_line_chart.dart';
import 'package:edu_diary/features/analytics/presentation/widgets/pie_chart.dart';
import 'package:edu_diary/sl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return BlocProvider<AnalyticsBloc>(
        create: (context) => sl()..add(LoadAnalyticsEvent(-1, 3)),
        child: Scaffold(
          appBar: AppBar(
            title: Text(locale.analytics),
            centerTitle: true,
          ),
          body: BlocBuilder<AnalyticsBloc, AnalyticsState>(
            builder: (context, state) {
              if (state is AnalyticsLoadedState) {
                return SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          DropdownButton(
                            items: [
                              DropdownMenuItem<int>(
                                  value: 1, child: Text(locale.first_quarter)),
                              DropdownMenuItem<int>(
                                  value: 2, child: Text(locale.second_quarter)),
                              DropdownMenuItem<int>(
                                  value: 3, child: Text(locale.third_quarter)),
                              DropdownMenuItem<int>(
                                  value: 4, child: Text(locale.fourth_quarter)),
                              DropdownMenuItem<int>(
                                  value: 5, child: Text(locale.year)),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                context.read<AnalyticsBloc>().add(
                                    LoadAnalyticsEvent(
                                        value, state.settings.$2));
                              }
                            },
                            value: state.settings.$1,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            locale.interval,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          DropdownButton(
                            items: [
                              DropdownMenuItem<int>(
                                  value: 1, child: Text(locale.one_day)),
                              DropdownMenuItem<int>(
                                  value: 2, child: Text(locale.two_days)),
                              DropdownMenuItem<int>(
                                  value: 3, child: Text(locale.three_days)),
                              DropdownMenuItem<int>(
                                  value: 7, child: Text(locale.seven_days)),
                              DropdownMenuItem<int>(
                                  value: 30, child: Text(locale.month)),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                context.read<AnalyticsBloc>().add(
                                    LoadAnalyticsEvent(
                                        state.settings.$1, value));
                              }
                            },
                            value: state.settings.$2,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            locale.average_progress,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          MarksLineChart(state.averageProgress.data,
                              state.averageProgress.labels),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            locale.marks_count,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          MarksPieChart(state.marksCount.data),
                          const SizedBox(
                            height: 32,
                          ),
                          Text(
                            locale.marks_count_progress,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          MarksMultiLineChart(state.marksCountProgress.data,
                              state.marksCountProgress.labels),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else if (state is AnalyticsFailState) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                        onPressed: () {
                          context
                              .read<AnalyticsBloc>()
                              .add((LoadAnalyticsEvent(-1, 3)));
                        },
                        child: Text(locale.retry))
                  ],
                ));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ));
  }
}
