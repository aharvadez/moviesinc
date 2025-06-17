import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:moviesinc/features/movies/ui/widgets/baseLayout/base_layout.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
    required this.title,
    required this.value,
    required this.themeNotifier,
  });

  final String title;
  final ThemeMode value;
  final ValueNotifier<ThemeMode> themeNotifier;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedSplashScreen(
      splashIconSize: double.infinity,
      splash: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [
                        const Color.fromARGB(255, 237, 188, 94),
                        const Color.fromARGB(255, 155, 124, 0),
                      ]
                    : [
                        const Color.fromARGB(255, 243, 210, 148),
                        const Color.fromARGB(255, 237, 188, 94),
                      ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: LottieBuilder.asset(
                "lib/core/assets/splashScreen/Animation.json",
                height: 250,
              ),
            ),
          );
        },
      ),
      nextScreen: BaseLayout(
        title: title,
        value: value,
        themeNotifier: themeNotifier,
      ),
    );
  }
}
