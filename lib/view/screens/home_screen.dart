import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../controller/providers/movie_provider.dart';

import '../widgets/movies_slider.dart';
import '../widgets/trending_slider.dart';
import 'favourites.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
        'MY Movies',
        style: TextStyle(
        color: Colors.red,
        fontSize: 30,
        fontWeight: FontWeight.bold,
        letterSpacing: 5,
    ),),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.red),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoriteScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Trending Movies",
                style: GoogleFonts.aBeeZee(fontSize: 25),
              ),
              const SizedBox(height: 32),
              movieProvider.isLoading
                  ? const Center(child: CircularProgressIndicator(color: Colors.red))
                  : TrendingSlider(movies: movieProvider.trendingMovies),

              const SizedBox(height: 32),

              Text(
                "Top Rated Movies",
                style: GoogleFonts.aBeeZee(fontSize: 25),
              ),
              const SizedBox(height: 32),
              movieProvider.isLoading
                  ? const Center(child: CircularProgressIndicator(color: Colors.red,))
                  : MoviesSlider(movies: movieProvider.topRatedMovies),

              const SizedBox(height: 32),

              Text(
                "Upcoming Movies",
                style: GoogleFonts.aBeeZee(fontSize: 25),
              ),
              const SizedBox(height: 32),
              movieProvider.isLoading
                  ? const Center(child: CircularProgressIndicator(color: Colors.red))
                  : MoviesSlider(movies: movieProvider.upComingMovies),
            ],
          ),
        ),
      ),
    );
  }
}