import 'package:flutter/cupertino.dart';

import '../../api/api.dart';
import '../../model/movie.dart';
import '../../sql_db/DatabaseHelper.dart';

class MovieProvider with ChangeNotifier {
  List<Movie> _trendingMovies = [];
  List<Movie> _topRatedMovies = [];
  List<Movie> _upComingMovies = [];
  List<Movie> _favoriteMovies = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();
  bool _isLoading = true;


  bool get isLoading => _isLoading;
  List<Movie> get trendingMovies => _trendingMovies;
  List<Movie> get topRatedMovies => _topRatedMovies;
  List<Movie> get upComingMovies => _upComingMovies;
  List<Movie> get favoriteMovies => _favoriteMovies;


  MovieProvider() {
    fetchMovies();
  }


  Future<void> fetchMovies() async {
    _isLoading = true;
    notifyListeners();

    try {
      _trendingMovies = await Api_.getTrendingMovies();
      _topRatedMovies = await Api_.getTopRatedMovies();
      _upComingMovies = await Api_.getUpComingMovies();


      await loadFavorites();
    } catch (error) {
      print('Error fetching movies: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> loadFavorites() async {
    try {
      _favoriteMovies = await _dbHelper.getFavorites();


      _updateFavoriteStatus(_trendingMovies);
      _updateFavoriteStatus(_topRatedMovies);
      _updateFavoriteStatus(_upComingMovies);

      notifyListeners();
    } catch (error) {
      print('Error loading favorites: $error');
    }
  }

  void _updateFavoriteStatus(List<Movie> movies) {
    for (var movie in movies) {
      movie.isFavorite = _favoriteMovies.any((fav) => fav.id == movie.id);
    }
  }

  void toggleFavorite(Movie movie) async {
    movie.isFavorite = !movie.isFavorite;

    try {
      if (movie.isFavorite) {
        await _dbHelper.insertFavorite(movie);
        _favoriteMovies.add(movie);
      } else {
        await _dbHelper.removeFavorite(movie.id!);
        _favoriteMovies.removeWhere((m) => m.id == movie.id);
      }
    } catch (error) {
      print('Error updating favorite status: $error');
    } finally {
      notifyListeners();
    }
  }
}