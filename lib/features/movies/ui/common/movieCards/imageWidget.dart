import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Imagewidget extends StatelessWidget {
  const Imagewidget({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: 150,
        child: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
    } else {
      return SizedBox(
        // width: double.infinity,
        height: 150,
        child: Center(
          child: Image.network(
            dotenv.env['TMDB_IMAGE_BASE_URL']! + imageUrl,
            fit: BoxFit
                .cover, // or BoxFit.fill / BoxFit.contain depending on your need
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) {
              return Center(child: Icon(Icons.error));
            },
          ),
        ),
      );
    }
  }
}
