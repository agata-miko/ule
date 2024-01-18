import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const String _databaseName = 'Hives.db';
  static const int _databaseVersion = 1;

  static Future<Database> initializeDatabase() async {
    final String path = join(await getDatabasesPath(), _databaseName);
    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Hive (
        hiveId TEXT PRIMARY KEY,
        hiveName TEXT,
        photoPath TEXT,
        note TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE Checklists (
        checklistId TEXT PRIMARY KEY,
        hiveId TEXT,
        checklistDate INTEGER,
        FOREIGN KEY (hiveId) REFERENCES Hive(hiveId)
      )
    ''');

    await db.execute('''
      CREATE TABLE QuestionAnswers (
        questionAnswerId TEXT PRIMARY KEY,
        checklistId TEXT,
        questionId TEXT,
        answerType TEXT,
        answer TEXT,
        FOREIGN KEY (checklistId) REFERENCES Checklists(checklistId)
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

  Future<int> updateHivePhoto(String hiveId, File newPhoto) async {
    Database db = await initializeDatabase();
    return await db.update(
      'Hive',
      {'photoPath': newPhoto.path},
      where: 'hiveId = ?',
      whereArgs: [hiveId],
    );
  }

  Future<int> updateHiveNote(String hiveId, String newNote) async {
    Database db = await initializeDatabase();
    return await db.update(
      'Hive',
      {'note': newNote},
      where: 'hiveId = ?',
      whereArgs: [hiveId],
    );
  }

  Future<String> getHiveNote(String hiveId) async {
    Database db = await initializeDatabase();
    List<Map<String, dynamic>> result = await db.query(
      'Hive',
      columns: ['note'],
      where: 'hiveId = ?',
      whereArgs: [hiveId],
    );

    if (result != null && result.isNotEmpty && result[0]['note'] != null) {
      return result[0]['note'];
    } else {
      return 'Notatki';
    }
  }

  Future<int> deleteHive(String hiveId) async {
    Database db = await initializeDatabase();
    return await db.delete('Hive', where: 'hiveId = ?', whereArgs: [hiveId]);
  }

  Future<int> insertChecklist(Map<String, dynamic> filledChecklist) async {
    Database db = await initializeDatabase();
    return await db.insert('Checklists', filledChecklist);
  }

  Future<List<Map<String, dynamic>>> getChecklists() async {
    Database db = await initializeDatabase();
    return await db.query('Checklists');
  }

  Future<int> deleteChecklist(String filledChecklistId) async {
    Database db = await initializeDatabase();
    return await db.delete('Checklists',
        where: 'filledChecklistId = ?', whereArgs: [filledChecklistId]);
  }

  Future<int> insertQuestionAnswer(Map<String, dynamic> questionAnswer) async {
    Database db = await initializeDatabase();
    return await db.insert('QuestionAnswers', questionAnswer);
  }

  Future<List<Map<String, dynamic>>> getAllQuestionAnswers() async {
    Database db = await initializeDatabase();
    return await db.query('Checklists');
  }


  //TYLKO DO TESTOW
  Future<void> printTables() async {
    final String path = join(await getDatabasesPath(), _databaseName);
    final Database db = await openDatabase(path);

    // Query to retrieve table names
    final List<Map<String, dynamic>> tables = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table';",
    );

    // Iterate through tables
    for (final table in tables) {
      final tableName = table['name'] as String;
      print('Table: $tableName');

      // Query to retrieve all rows from the current table
      final List<Map<String, dynamic>> rows = await db.query(tableName);

      // Print column names
      print('Columns: ${rows.isNotEmpty ? rows[0].keys.join(', ') : 'No data'}');

      // Print each row
      for (final row in rows) {
        print(row);
      }

      print('\n'); // Add a newline for better readability
    }

    // Close the database when done
    await db.close();
  }
  // Future<List<FilledChecklist>> getAllChecklists() async {
  //   Database db = await initializeDatabase();
  //   List<Map<String, dynamic>> checklistData = await db.query('Checklist');
  //
  //   List<FilledChecklist> checklists = [];
  //
  //   for (var data in checklistData) {
  //     String checklistId = data['checklistId'];
  //     String hiveId = data['hiveId'];
  //     DateTime checklistDate =
  //     DateTime.fromMillisecondsSinceEpoch(data['checklistDate']);
  //
  //     List<Map<String, dynamic>> questionData = await db.query('Checklist',
  //         where: 'checklistId = ?', whereArgs: [checklistId]);
  //
  //     List<Question> questions = [];
  //
  //     for (var question in questionData) {
  //       String questionId = question['questionId'];
  //
  //       // Find the corresponding question in checklistQuestions
  //       Question? foundQuestion;
  //       for (var q in checklistQuestions) {
  //         if (q.id == questionId) {
  //           foundQuestion = q;
  //           break;
  //         }
  //       }
  //
  //       questions.add(Question(
  //         id: question['questionId'],
  //         response: question['response'],
  //         text: foundQuestion?.text ?? 'Not Found',
  //         responseType: foundQuestion?.responseType ?? ResponseType.text,
  //       ));
  //     }

  //   checklists.add(FilledChecklist(
  //     hiveId: hiveId as int,
  //     checklistDate: checklistDate,
  //     answers: questions,
  //   ));
  // }

  //   return checklists;
  // }
}
