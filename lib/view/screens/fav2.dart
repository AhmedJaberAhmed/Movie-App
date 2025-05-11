import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../controller/providers/movie_provider.dart';
import 'DetailsScreen2.dart';

class FavoriteScreen2 extends StatefulWidget {
  const FavoriteScreen2({super.key});

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen2> {
  @override
  void initState() {
    super.initState();

    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    movieProvider.loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);
    final favoriteMovies = movieProvider.favoriteMovies;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Movies"),
        centerTitle: true,
      ),
      body: favoriteMovies.isEmpty
          ? Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            textAlign: TextAlign.center,
            "No favorite movies yet!",
            style: GoogleFonts.roboto(
                color: Colors.red,
                fontSize: 39,
                fontWeight: FontWeight.bold),
          ),
        ),
      )
          : ListView.builder(
        itemCount: favoriteMovies.length,
        itemBuilder: (context, index) {
          final movie = favoriteMovies[index];

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            elevation: 4,
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),leading: Container(
              width: 100,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(
                    'lib/assets/movie____.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

              title: Text(
                movie.title,
                style:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.overview,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Release Date: ${movie.releaseDate}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: Icon(
                  movie.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: movie.isFavorite ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  // Toggle favorite status
                  movieProvider.toggleFavorite(movie);
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen2(movie: movie),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
