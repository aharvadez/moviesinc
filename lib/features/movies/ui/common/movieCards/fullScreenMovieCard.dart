import 'package:flutter/material.dart';
import 'package:moviesinc/features/movies/ui/common/movieCards/imageWidget.dart';

class FullScreenMovieCard extends StatelessWidget {
  final String? title;
  final String? year;
  final String? genre;
  final double? rating;
  final String? posterUrl;

  const FullScreenMovieCard({
    super.key,
    this.title,
    this.year,
    this.genre,
    this.rating,
    this.posterUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(1, 0, 0, 0),
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Close Button
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Expanded(
            child: Center(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 10,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title ?? '',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '$year • $genre',
                        style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 24),
                          SizedBox(width: 4),
                          Text(
                            rating?.toString() ?? '',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Imagewidget(imageUrl: posterUrl ?? ''),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
