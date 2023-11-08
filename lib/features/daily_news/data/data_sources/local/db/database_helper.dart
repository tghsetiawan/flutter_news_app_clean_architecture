import 'dart:async';

import 'package:flutter_news_app_clean_architecture/features/daily_news/data/models/article_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblFavorite = 'favorite';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/dailynews.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblFavorite (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  Future<int> insertWatchlist(ArticleModel news) async {
    final db = await database;
    return await db!.insert(_tblFavorite, news.toJson());
  }

  Future<int> removeWatchlist(ArticleModel news) async {
    final db = await database;
    return await db!.delete(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [news.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblFavorite);

    return results;
  }
}
