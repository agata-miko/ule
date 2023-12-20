import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const String _databaseName = 'Hives.dB';
  static const int _databaseVersion = 1;

  static Future<Database> initializeDatabase() async {
    final String path = join(await getDatabasesPath(), _databaseName);
    return openDatabase(path,
        onCreate: _onCreate);
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Hive (
        hiveId TEXT PRIMARY KEY,
        hiveName TEXT,
        photoPath TEXT,
        notes TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE Checklist (
        checklistId TEXT PRIMARY KEY,
        hiveId TEXT,
        checklistDate INTEGER,
        answers TEXT,
        FOREIGN KEY (hiveId) REFERENCES Hive(hiveId)
      )
    ''');
  }

  Future<int> insertHive(Map<String, dynamic> hive) async {
    Database db = await initializeDatabase();
    return await db.insert('Hive', hive);
  }

  Future<List<Map<String, dynamic>>> getAllHives() async {
    Database db = await initializeDatabase();
    return await db.query('Hive');
  }

  Future<int> updateHive(Map<String, dynamic> hive) async {
    Database db = await initializeDatabase();
    return await db.update('Hive', hive,
        where: 'hiveId = ?', whereArgs: [hive['hiveId']]);
  }

  Future<int> deleteHive(String hiveId) async {
    Database db = await initializeDatabase();
    return await db.delete('Hive', where: 'hiveId = ?', whereArgs: [hiveId]);
  }

  Future<int> insertChecklist(Map<String, dynamic> checklist) async {
    Database db = await initializeDatabase();
    return await db.insert('Checklist', checklist);
  }

  Future<List<Map<String, dynamic>>> getAllChecklists() async {
    Database db = await initializeDatabase();
    return await db.query('Checklist');
  }

  Future<int> updateChecklist(Map<String, dynamic> checklist) async {
    Database db = await initializeDatabase();
    return await db.update('Checklist', checklist,
        where: 'checklistId = ?', whereArgs: [checklist['checklistId']]);
  }

  Future<int> deleteChecklist(String checklistId) async {
    Database db = await initializeDatabase();
    return await db.delete('Checklist', where: 'checklistId = ?', whereArgs: [checklistId]);
  }
}
