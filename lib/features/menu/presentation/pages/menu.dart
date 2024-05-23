import 'package:edu_diary/features/menu/presentation/bloc/menu_bloc.dart';
import 'package:edu_diary/features/menu/presentation/widgets/button.dart';
import 'package:edu_diary/features/menu/presentation/widgets/title.dart';
import 'package:edu_diary/sl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MenuBloc>(
      create: (context) => sl()..add(MenuInitEvent()),
      child: BlocBuilder<MenuBloc, MenuState>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 4,
                      ),
                      menuTitleWidget(),
                      const SizedBox(
                        height: 8,
                      ),
                      menuButton(
                        text: 'Performance',
                        icon: Icons.receipt_long,
                        isLoaded: state is MenuLoadedState && state.isPerformanceLoaded,
                        firstGradientColor:
                            const Color.fromARGB(255, 177, 18, 255),
                        secondGradientColor:
                            const Color.fromARGB(255, 36, 144, 252),
                        action: () {
                          
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      menuButton(
                        text: 'Diary',
                        icon: Icons.event_note,
                        isLoaded: true,
                        firstGradientColor:
                            const Color.fromARGB(255, 0, 196, 255),
                        secondGradientColor:
                            const Color.fromARGB(255, 146, 254, 157),
                        action: () {},
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      menuButton(
                        text: 'Analytics',
                        icon: Icons.bar_chart,
                        isLoaded: true,
                        firstGradientColor:
                            const Color.fromARGB(255, 217, 0, 255),
                        secondGradientColor:
                            const Color.fromARGB(255, 255, 166, 83),
                        action: () {},
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      menuButton(
                        text: 'News',
                        icon: Icons.newspaper,
                        isLoaded: true,
                        firstGradientColor: const Color.fromARGB(255, 255, 1, 2),
                        secondGradientColor:
                            const Color.fromARGB(255, 240, 203, 53),
                        action: () {
                          
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      menuButton(
                        text: 'Profile',
                        isLoaded: true,
                        icon: Icons.person,
                        firstGradientColor:
                            const Color.fromARGB(255, 81, 194, 111),
                        secondGradientColor:
                            const Color.fromARGB(255, 255, 247, 46),
                        action: () {
                          
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
