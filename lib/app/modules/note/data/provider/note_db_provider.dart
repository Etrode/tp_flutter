import 'dart:async';
import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class NoteDbProvider {
  static final _databaseName = "note.db";
  static final _databaseVersion = 1;
  static final table = 'note';
  static final cId = '_id';
  static final cTitle = 'title';
  static final cDate = 'date';
  static final cContenu = 'contenu';
  static final cImagePath = 'image_path';

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $table(
      $cId INTEGER PRIMARY KEY,
      $cTitle TEXT NOT NULL,
      $cDate TEXT,
      $cContenu TEXT,
      $cImagePath TEXT
    )
    ''');
  }

  // inserer une Map dans la table note
  Future<int> insert(Map<String, dynamic> data) async {
    Database? db = await database;
    return await db!.insert(table, data);
  }

  // Lire toutes les données dans la table note
  Future<List<Map<String, dynamic>>> query() async {
    Database? db = await database;
    return db!.query(table);
  }
}
