import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const String _databaseName = 'Hives.dB';
  static const int _databaseVersion = 1;

  static Future<Database> _initializeDatabase() async {
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
}
