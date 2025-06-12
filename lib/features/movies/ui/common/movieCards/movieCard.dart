import 'package:flutter/material.dart';
import 'package:moviesinc/features/movies/ui/common/movieCards/fullScreenMovieCard.dart';
import 'package:moviesinc/features/movies/ui/common/movieCards/imageWidget.dart';

class MovieCard extends StatelessWidget {
  final String? title;
  final String? year;
  final String? genre;
  final double? rating;
  final String? posterUrl;
  final bool isLoading;

  const MovieCard({
    super.key,
    this.title,
    this.year,
    this.genre,
    this.rating,
    this.posterUrl,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildLoadingCard();
    } else {
      return GestureDetector(
        onTap: () {
          showGeneralDialog(
            context: context,
            barrierDismissible: true,
            barrierLabel: 'Close',
            barrierColor: Colors.black.withOpacity(0.2),
            transitionDuration: Duration(milliseconds: 300),
            pageBuilder: (_, __, ___) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.black.withOpacity(0.9),
                    child: SafeArea(
                      child: FullScreenMovieCard(
                        title: title,
                        year: year,
                        genre: genre,
                        rating: rating,
                        posterUrl: posterUrl,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: _buildCard(),
      );
    }
  }

  Widget _buildLoadingCard() {
    return SizedBox(
      width: 100,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(8),
              width: double.infinity,
              // height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16),
              ),
              // constraints: BoxConstraints(
              //   minHeight: 80, // Optional: set a minimum height if needed
              // ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(width: 80, height: 20, color: Colors.grey[300]),
                  SizedBox(height: 4),
                  Container(width: 60, height: 14, color: Colors.grey[300]),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.grey[300], size: 18),
                      SizedBox(width: 4),
                      Container(width: 20, height: 14, color: Colors.grey[300]),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard() {
    return SizedBox(
      width: 100, // set your desired width
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SizedBox(
          width: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Imagewidget(imageUrl: posterUrl ?? ''),

              // Movie details
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title ?? '',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '$year • $genre',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 18),
                        SizedBox(width: 4),
                        Text(
                          rating.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
