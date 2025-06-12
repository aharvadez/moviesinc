import 'package:flutter/material.dart';

class SearchBarCust extends StatelessWidget {
  const SearchBarCust({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 15,
      left: 16,
      right: 16,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(30),
        child: TextField(
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
