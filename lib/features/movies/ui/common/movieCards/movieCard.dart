import 'package:flutter/material.dart';
import 'package:moviesinc/features/movies/repository/entities/movieEntityModel.dart';
import 'package:moviesinc/features/movies/ui/common/movieCards/fullScreenMovieCard.dart';
import 'package:moviesinc/features/movies/ui/common/movieCards/imageWidget.dart';
import 'package:moviesinc/features/movies/ui/widgets/favButton/favButton.dart';

class MovieCard extends StatelessWidget {
  final MovieEntityModel? movie;
  final bool isLoading;

  const MovieCard({super.key, this.movie, this.isLoading = false})
    : assert((movie != null) || isLoading);

  @override
  Widget build(BuildContext context) {
    if (isLoading || movie == null) {
      return _buildLoadingCard();
    } else {
      return GestureDetector(
        onTap: () {
          showGeneralDialog(
            context: context,
            barrierDismissible: true,
            barrierLabel: 'Close',
            barrierColor: Colors.black.withAlpha(1),
            transitionDuration: Duration(milliseconds: 300),
            pageBuilder: (_, __, ___) {
              return FullScreenMovieCard(movie: movie!);
            },
          );
        },
        child: _buildCard(context),
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
              constraints: BoxConstraints(
                minHeight: 80, // Optional: set a minimum height if needed
              ),
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

  Widget _buildCard(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Imagewidget(imageUrl: movie?.posterUrl ?? ''),
                ),
                Positioned(top: 6, right: 6, child: Favbutton(movie: movie!)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    movie?.title ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${movie?.year ?? ''} • ${movie?.genre ?? ''}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      SizedBox(width: 4),
                      Text(
                        "${movie?.rating ?? ''}",
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
    );
  }
}
