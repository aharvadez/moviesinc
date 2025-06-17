import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Imagewidget extends StatelessWidget {
  const Imagewidget({super.key, required this.imageUrl});
  final String imageUrl;

  String getFullImageUrl(String imageUrl) {
    if (imageUrl[0] == '/') {
      return '${dotenv.env['TMDB_IMAGE_BASE_URL']!}${imageUrl.substring(1)}';
    } else {
      // Treat as a remote image from TMDB
      return '${dotenv.env['TMDB_IMAGE_BASE_URL']!}$imageUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0), // Top padding added here
      child: imageUrl.isEmpty
          ? SizedBox(
              width: double.infinity,
              height: 150,
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            )
          : SizedBox(
              width: double.infinity,
              height: 150,
              child: Center(
                child: Image.network(
                  getFullImageUrl(imageUrl),
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Center(child: Icon(Icons.error));
                  },
                ),
              ),
            ),
    );
  }
}
