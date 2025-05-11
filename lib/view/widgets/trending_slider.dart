import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../constants/const.dart';
import '../../controller/providers/movie_provider.dart';
import '../../model/movie.dart';
import '../screens/details_screen.dart';
import 'package:provider/provider.dart';

class TrendingSlider extends StatelessWidget {
  final List<Movie> movies;

  const TrendingSlider({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: movies.length,
      itemBuilder: (context, index, realIndex) {
        Movie movie = movies[index];

        return Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(movie: movie),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  "${Constants.imagePath}${movie.posterPath}",
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Consumer<MovieProvider>(
                builder: (context, provider, _) {

                  bool isFavorite = provider.favoriteMovies
                      .any((favMovie) => favMovie.id == movie.id);

                  return IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      provider.toggleFavorite(movie);
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
      options: CarouselOptions(
        height: 300,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.55,
        autoPlayCurve: Curves.fastOutSlowIn,
        autoPlayAnimationDuration: const Duration(seconds: 1),
      ),
    );
  }
}