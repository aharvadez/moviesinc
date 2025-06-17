import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesinc/features/movies/bloc/search/search_bloc.dart';

class SearchBarCust extends StatefulWidget {
  const SearchBarCust({super.key});

  @override
  State<SearchBarCust> createState() => _SearchBarCustState();
}

class _SearchBarCustState extends State<SearchBarCust> {
  Timer? _debounce;
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 400), () {
      if (query.length > 3) {
        context.read<SearchBloc>().add(SearchEventQueryChanged(query: query));
      } else if (query.isEmpty) {
        // Reset the state if query is empty
        if (context.read<SearchBloc>().state is! SearchStateInitial) {
          context.read<SearchBloc>().add(SearchEventLoadInitial());
        }
      }
    });
  }

  void _clearSearch() {
    _controller.clear();
    _debounce?.cancel();

    final bloc = context.read<SearchBloc>();
    final currentState = bloc.state;
    if (currentState is! SearchStateInitial) {
      bloc.add(SearchEventLoadInitial());
    }
    setState(() {}); // to hide the clear icon
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Material(
        elevation: 8,

        borderRadius: BorderRadius.circular(30),
        child: TextFormField(
          controller: _controller,
          onChanged: (value) {
            _onSearchChanged(value);
            setState(() {}); // update UI to show/hide clear icon
          },
          decoration: InputDecoration(
            hintText: "Search...",
            prefixIcon: Icon(Icons.search),
            suffixIcon: _controller.text.isNotEmpty
                ? IconButton(icon: Icon(Icons.close), onPressed: _clearSearch)
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 14,
            ),
          ),
        ),
      ),
    );
  }
}
