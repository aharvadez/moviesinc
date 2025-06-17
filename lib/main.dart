import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:moviesinc/core/constants/themes.dart';
import 'package:moviesinc/core/utils/objectbox_helper.dart';
import 'package:moviesinc/features/movies/bloc/favorities/favorities_bloc.dart';
import 'package:moviesinc/features/movies/repository/db_repository.dart';
import 'package:moviesinc/features/movies/ui/pages/splash_screen.dart';

late ObjectBox objectBox;

void main() async {
  await dotenv.load(fileName: ".env");
  objectBox = await ObjectBox.create();
  MaintainGenreIds().saveGenreIds();
  // objectBox.movieBox.removeAll();
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

          home: MultiBlocProvider(
            providers: [
              BlocProvider<FavoritiesBloc>(
                create: (context) => FavoritiesBloc(),
              ),
            ],
            child: SplashScreen(
              title: 'Movies Inc.',
              value: _themeNotifier.value,
              themeNotifier: _themeNotifier,
            ),
          ),
        );
      },
    );
  }
}
