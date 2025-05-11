import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../model/movie.dart';

class Api_ {

  static Future<String> downloadAndSaveImage(String url, String filename) async {

    final response = await http.get(Uri.parse(url));
    final directory = await getApplicationDocumentsDirectory();


    final filePath = '${directory.path}/$filename';
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);

    return filePath;
  }

  static const String _baseUrl = "https://api.themoviedb.org/3";
  static const String _apiKey = "76b0d70f3c58a6af2299769af12ca504";

  static Future<List<Movie>> getTrendingMovies() async {
    final response = await http.get(Uri.parse('$_baseUrl/trending/movie/week?api_key=$_apiKey'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['results'];
      return jsonResponse.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load trending movies');
    }
  }

  static Future<List<Movie>> getTopRatedMovies() async {
    final response = await http.get(Uri.parse('$_baseUrl/movie/top_rated?api_key=$_apiKey'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['results'];
      return jsonResponse.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load top-rated movies');
    }
  }

  static Future<List<Movie>> getUpComingMovies() async {
    final response = await http.get(Uri.parse('$_baseUrl/movie/upcoming?api_key=$_apiKey'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['results'];
      return jsonResponse.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load upcoming movies');
    }
  }
}
