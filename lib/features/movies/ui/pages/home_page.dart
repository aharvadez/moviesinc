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
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageBloc(),
      child: Scaffold(
        body: BlocBuilder<HomePageBloc, HomePageState>(
          builder: (context, state) {
            if (state is HomePageInitial) {
              context.read<HomePageBloc>().add(HomePageLoadEvent());
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomePageLoading) {
              return GridCreator();
            } else if (state is HomePageLoaded) {
              return GridCreator(movieList: state.movieList);
            } else if (state is HomePageError) {
              return Center(child: Text(state.error));
            }
            return Center(child: Text("Error Loading Movies"));
          },
        ),
      ),
    );
  }
}
