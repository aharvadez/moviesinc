import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesinc/features/movies/bloc/homepage/homepage_bloc.dart';
import 'package:moviesinc/features/movies/ui/widgets/grid/movieGridBuilder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 500) {
      context.read<HomePageBloc>().add(HomePageLoadEvent());
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<HomePageBloc>().add(HomePageLoadEvent());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          if (state is HomePageInitial ||
              state is HomePageLoading && state is! HomePageLoaded) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomePageLoading) {
            return GridCreator();
          } else if (state is HomePageLoaded) {
            return GridCreator(
              movieList: state.movieList,
              scrollController: _scrollController,
              isLoadingMore: !state.hasReachedMax,
            );
          } else if (state is HomePageError) {
            return Center(child: Text(state.error));
          }
          return Center(child: Text("Error Loading Movies"));
        },
      ),
    );
  }
}
