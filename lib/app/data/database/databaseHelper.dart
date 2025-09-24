// lib/app/data/database/databaseHelper.dart
import 'package:mflplayer/app/data/dao/m3u_item_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _db;
  final int _version = 1;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'mfl.db');
    return await openDatabase(
      path,
      version: _version,
      onConfigure: (db) async {
        // Configure database for pragma wal
        await db.rawQuery('PRAGMA journal_mode = WAL');
      },
      onCreate: (db, version) async {
        await db.execute(M3UItemDao.createTable);

        // Create index
        await db.execute(M3UItemDao.createIndexGroupTitle);
      },
    );
  }

  // Metodo para limpar o database
  Future<void> clearDatabase() async {
    final database = await db;
    await database.delete(M3UItemDao.tableName);
  }
}
