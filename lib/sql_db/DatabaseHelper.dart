import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/movie.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'movies.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE favorites (
            id INTEGER PRIMARY KEY,
            title TEXT,
            backDropPath TEXT,
            originalTitle TEXT,
            overview TEXT,
            posterPath TEXT,
            releaseDate TEXT,
            voteAverage REAL,
            isFavorite INTEGER
          )
        ''');
      },
    );
  }


  Future<void> insertFavorite(Movie movie) async {
    final db = await database;
    try {
      await db.insert(
        'favorites',
        movie.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Movie inserted successfully: ${movie.title}');
    } catch (e) {
      print('Error inserting movie: $e');
    }
  }


  Future<void> removeFavorite(int id) async {
    final db = await database;
    try {
      await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
      print('Movie removed successfully: ID $id');
    } catch (e) {
      print('Error removing movie: $e');
    }
  }


  Future<List<Movie>> getFavorites() async {
    final db = await database;
    try {
      final List<Map<String, dynamic>> maps = await db.query('favorites');
      return List.generate(maps.length, (i) {
        return Movie.fromMap(maps[i]);
      });
    } catch (e) {
      print('Error fetching favorites: $e');
      return [];
    }
  }
}
