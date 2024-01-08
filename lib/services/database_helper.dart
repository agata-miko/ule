import 'dart:io';

import 'package:pszczoly_v3/data/checklist_questions_data.dart';
import 'package:pszczoly_v3/models/checklist_responses.dart';
import 'package:pszczoly_v3/models/question.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:pszczoly_v3/models/hive.dart';

class DatabaseHelper {
  static const String _databaseName = 'Hives.db';
  static const int _databaseVersion = 1;

  static Future<Database> initializeDatabase() async {
    final String path = join(await getDatabasesPath(), _databaseName);
    return openDatabase(path, version: _databaseVersion,
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
      CREATE TABLE Checklists (
        checklistId TEXT PRIMARY KEY,
        hiveId TEXT,
        checklistDate INTEGER,
        questionId TEXT,
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

  Future<int> insertChecklist(ChecklistResponses checklist) async {
    Database db = await initializeDatabase();
    int checklistId = await db.insert('Checklist', {
      'hiveId': checklist.hiveId,
      'checklistDate': checklist.checklistDate.millisecondsSinceEpoch,
    });

    for (var question in checklist.answers) {
      await db.insert('Checklist', {
        'checklistId': checklistId,
        'questionId': question.id,
        'response': question.response,
      });
    }

    return checklistId;
  }

  Future<List<ChecklistResponses>> getAllChecklists() async {
    Database db = await initializeDatabase();
    List<Map<String, dynamic>> checklistData = await db.query('Checklist');

    List<ChecklistResponses> checklists = [];

    for (var data in checklistData) {
      String checklistId = data['checklistId'];
      String hiveId = data['hiveId'];
      DateTime checklistDate =
      DateTime.fromMillisecondsSinceEpoch(data['checklistDate']);

      List<Map<String, dynamic>> questionData = await db.query('Checklist',
          where: 'checklistId = ?', whereArgs: [checklistId]);

      List<Question> questions = [];

      for (var question in questionData) {
        String questionId = question['questionId'];

        // Find the corresponding question in checklistQuestions
        Question? foundQuestion;
        for (var q in checklistQuestions) {
          if (q.id == questionId) {
            foundQuestion = q;
            break;
          }
        }

        questions.add(Question(
          id: question['questionId'],
          response: question['response'],
          text: foundQuestion?.text ?? 'Not Found',
          responseType: foundQuestion?.responseType ?? ResponseType.text,
        ));
      }

      checklists.add(ChecklistResponses(
        hiveId: hiveId as int,
        checklistDate: checklistDate,
        answers: questions,
      ));
    }

    return checklists;
  }


  Future<int> updateChecklist(Map<String, dynamic> checklist) async {
    Database db = await initializeDatabase();
    return await db.update('Checklist', checklist,
        where: 'checklistId = ?', whereArgs: [checklist['checklistId']]);
  }

  Future<int> deleteChecklist(String checklistId) async {
    Database db = await initializeDatabase();
    return await db.delete(
        'Checklist', where: 'checklistId = ?', whereArgs: [checklistId]);
  }
}
