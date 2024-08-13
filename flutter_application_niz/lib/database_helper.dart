import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), "my_database.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE my_table(
            id INTEGER PRIMARY KEY,
            title TEXT,
            is_finish INTEGER
          )
        ''');
      },
    );
  }

  Future<List<Map<String, dynamic>>> getAllData() async {
    final Database? db = await database;
    return await db!.query('my_table');
  }

  Future<void> insertData(Map<String, dynamic> data) async {
    final Database? db = await database;
    await db!
        .insert('my_table', data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateData(int id, Map<String, dynamic> data) async {
    final Database? db = await database;
    return await db!.update('my_table', data, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteData(int id) async {
    final Database? db = await database;
    return await db!.delete('my_table', where: 'id = ?', whereArgs: [id]);
  }
}
