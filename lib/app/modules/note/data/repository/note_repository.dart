import 'dart:async';

import 'package:tp_flutter/app/modules/note/data/provider/note_db_provider.dart';
import 'package:tp_flutter/app/modules/note/model/note_model.dart';

class NoteRepository {
  final dbProvider = NoteDbProvider();

  insertNote(NoteModel noteModel) async {
    await dbProvider.insert(noteModel.toJson());
  }

  Future<List<NoteModel>> retrieve() async {
    final List<Map<String, dynamic>> noteList = await dbProvider.query();
    List<NoteModel> newNoteLists =
        noteList.map((e) => NoteModel.fromJson(e)).toList();
    return newNoteLists;
  }
}
