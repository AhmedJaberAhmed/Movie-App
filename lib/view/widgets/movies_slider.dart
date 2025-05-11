import 'package:flutter/material.dart';

import '../../constants/const.dart';
import '../../controller/providers/movie_provider.dart';
import '../../model/movie.dart';
import '../screens/details_screen.dart';
import 'package:provider/provider.dart';

class MoviesSlider extends StatelessWidget {
  final List<Movie> movies;

  const MoviesSlider({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: movies.length,
        itemBuilder: (context, index) {
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      height: 200,
                      width: 150,
                      child: Image.network(
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                        '${Constants.imagePath}${movie.posterPath}',
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Consumer<MovieProvider>(
                  builder: (context, provider, child) {

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
      ),
    );
  }
}
