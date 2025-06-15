import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/auth_tokens_model.dart';

class AuthLocalDataSource {
  static const _dbName = 'auth.db';
  static const _table = 'session';
  Database? _db;

  Future<Database> get _database async {
    if (_db != null) return _db!;
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, _dbName);
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('CREATE TABLE $_table(id INTEGER PRIMARY KEY, accessToken TEXT, refreshToken TEXT)');
      },
    );
    return _db!;
  }

  Future<void> saveTokens(AuthTokensModel tokens) async {
    final db = await _database;
    await db.delete(_table);
    await db.insert(_table, {
      'id': 1,
      'accessToken': tokens.accessToken,
      'refreshToken': tokens.refreshToken,
    });
  }

  Future<AuthTokensModel?> getTokens() async {
    final db = await _database;
    final data = await db.query(_table, where: 'id = ?', whereArgs: [1]);
    if (data.isEmpty) return null;
    final map = data.first;
    return AuthTokensModel(
      accessToken: map['accessToken'] as String,
      refreshToken: map['refreshToken'] as String,
    );
  }

  Future<void> clearTokens() async {
    final db = await _database;
    await db.delete(_table);
  }
}
