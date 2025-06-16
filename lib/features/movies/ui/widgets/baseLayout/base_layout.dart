import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesinc/features/movies/bloc/favorities/favorities_bloc.dart';
import 'package:moviesinc/features/movies/bloc/homepage/homepage_bloc.dart';
import 'package:moviesinc/features/movies/ui/pages/favorities_page.dart';
import 'package:moviesinc/features/movies/ui/pages/home_page.dart';
import 'package:moviesinc/features/movies/ui/pages/search_page.dart';

class BaseLayout extends StatefulWidget {
  const BaseLayout({
    super.key,
    required this.title,
    required this.value,
    required this.themeNotifier,
  });
  final String title;
  final ThemeMode value;
  final ValueNotifier<ThemeMode> themeNotifier;

  @override
  State<BaseLayout> createState() => _BaseLayoutState();
}

class _BaseLayoutState extends State<BaseLayout> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [HomePage(), SearchPage(), FavoritiesPage()];
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FavoritiesBloc>(create: (_) => FavoritiesBloc()),
        BlocProvider<HomePageBloc>(create: (_) => HomePageBloc()),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          centerTitle: false,
          title: Text(
            widget.title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          actions: [
            IconButton(
              icon: widget.value == ThemeMode.light
                  ? Icon(Icons.toggle_off, size: 50)
                  : Icon(Icons.toggle_on, size: 50),
              color: Theme.of(context).colorScheme.onPrimary,
              onPressed: () {
                widget.themeNotifier.value =
                    widget.themeNotifier.value == ThemeMode.light
                    ? ThemeMode.dark
                    : ThemeMode.light;
              },
            ),
          ],
        ),
        body: IndexedStack(index: _selectedIndex, children: _pages),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onTabTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
          ],
        ),
      ),
    );
  }
}
