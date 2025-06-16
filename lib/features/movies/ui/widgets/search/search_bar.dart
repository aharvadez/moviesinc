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

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 400), () {
      if (query.length > 3) {
        context.read<SearchBloc>().add(SearchEventQueryChanged(query: query));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 15,
      left: 16,
      right: 16,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(30),
        child: TextFormField(
          onChanged: _onSearchChanged,
          decoration: InputDecoration(
            hintText: "Search...",
            prefixIcon: Icon(Icons.search),
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
