import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tp_flutter/app/modules/note/model/note_model.dart';
import 'package:tp_flutter/app/screens/home/home_screen.dart';
import 'package:tp_flutter/app/screens/note-details/note_details_screen.dart';

const kHomeRoute = '/home';
const kNoteDetailsRoute = '/note-details';

final Map<String, WidgetBuilder> kRoutes = {
  kHomeRoute: (_) => HomeScreen(),
};

onGenerateRoute(settings) {
  if (settings.name == kNoteDetailsRoute) {
    NoteModel data = settings.arguments;
    return MaterialPageRoute(
        builder: (_) => NoteDetailsScreen(noteModel: data));
  }
}
