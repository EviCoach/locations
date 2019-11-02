import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    // create the database if one doesn't exist.
    // final dbPath = await sql.getDatabasesPath() ?? 'user_places'; // where to store the databse.
    // either open an existing one or create a new one
    // the path argument is not just a db path, it has to include the database name
    // with the .db extension
    return sql.openDatabase(path.join('user', 'places.db'),
        onCreate: (db, version) {
      print('table created...');
      return db.execute(
          'CREATE TABLE userplaces (id TEXT PRIMARY KEY, title TEXT, image TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final sqlDb = await DBHelper.database();
    await sqlDb.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
