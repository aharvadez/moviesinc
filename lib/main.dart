import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:moviesinc/core/constants/themes.dart';
import 'package:moviesinc/features/movies/ui/widgets/baseLayout/base_layout.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(MoviesApp());
}

class MoviesApp extends StatelessWidget {
  MoviesApp({super.key});

  final ValueNotifier<ThemeMode> _themeNotifier = ValueNotifier(ThemeMode.dark);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _themeNotifier,
      builder: (context, value, child) {
        return MaterialApp(
          title: 'Movies Inc.',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: _themeNotifier.value,

          home: BaseLayout(
            title: 'Movies Inc.',
            value: _themeNotifier.value,
            themeNotifier: _themeNotifier,
          ),
        );
      },
    );
  }
}
