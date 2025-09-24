import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import '../model/m3u_item.dart';
import '../database/databaseHelper.dart';

class M3UItemDao {
  final DatabaseHelper _dbHelper = Get.find<DatabaseHelper>();

  Future<int> insert(M3UItem item) async {
    final db = await _dbHelper.db;
    return await db.insert(tableName, item.toMap());
  }

  Future<List<M3UItem>> getAllItems() async {
    final db = await _dbHelper.db;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return M3UItem.fromJson(maps[i]);
    });
  }

  // get items by group title
  Future<List<M3UItem>> getItemsByGroupTitle(String groupTitle) async {
    final db = await _dbHelper.db;
    final List<Map<String, dynamic>> maps = await db.query(
        tableName,
        where: 'LOWER($columnGroupTitle) LIKE ?',
        whereArgs: ['${groupTitle.toLowerCase()}%'],
        orderBy: "$columnName ASC, $columnTvgName ASC",
    );

    return List.generate(maps.length, (i) {
      return M3UItem.fromJson(maps[i]);
    });
  }

  // get items by group title
  Future<List<M3UItem>> getItemsByGroupTitleWithGroupBy(String groupTitle) async {
    final db = await _dbHelper.db;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'LOWER($columnGroupTitle) LIKE ?',
      whereArgs: ['${groupTitle.toLowerCase()}%'],
      orderBy: "$columnName ASC, $columnTvgName ASC",
      groupBy: columnGroupTitle
    );

    return List.generate(maps.length, (i) {
      return M3UItem.fromJson(maps[i]);
    });
  }

  // Check exist data in table
  Future<bool> hasData() async {
    final db = await _dbHelper.db;
    final count = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM $tableName'),
    );
    return count != null && count > 0;
  }

  Future<void> insertBatchPartitioned(List<M3UItem> items, {int batchSize = 500}) async {
    final db = await _dbHelper.db;
    for (var i = 0; i < items.length; i += batchSize) {
      final batchItems = items.sublist(
        i,
        i + batchSize > items.length ? items.length : i + batchSize,
      );
      await db.transaction((txn) async {
        final batch = txn.batch();
        for (var item in batchItems) {
          batch.insert(tableName, item.toMap());
        }
        await batch.commit(noResult: true);
      });
    }
  }

  // Create table name and columns
  static const String tableName = 'm3u_items';
  static const String columnId = 'id';
  static const String columnName = 'name';
  static const String columnUrl = 'url';
  static const String columnTvgName = 'tvgName';
  static const String columnTvgLogo = 'tvgLogo';
  static const String columnGroupTitle = 'groupTitle';

  // Create table SQL
  static const String createTable = '''
    CREATE TABLE $tableName (
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnName TEXT,
      $columnUrl TEXT,
      $columnTvgName TEXT,
      $columnTvgLogo TEXT,
      $columnGroupTitle TEXT
    )
  ''';

  static const String dropTable = '''
    DROP TABLE IF EXISTS $tableName
  ''';

  // Criar index para otimizar consultas por groupTitle
  static const String createIndexGroupTitle = '''
    CREATE INDEX idx_group_title ON $tableName ($columnGroupTitle)
  ''';
}
