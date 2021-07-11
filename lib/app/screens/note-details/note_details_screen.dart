import 'package:flutter/material.dart';
import 'package:tp_flutter/app/modules/note/model/note_model.dart';
import 'package:tp_flutter/app/screens/home/widgets/image_element.dart';

class NoteDetailsScreen extends StatelessWidget {
  const NoteDetailsScreen({required this.noteModel});
  final NoteModel noteModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.black,
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'MES NOTES',
            style: TextStyle(
                fontSize: 34, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${noteModel.title} # ${noteModel.id} ',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                      '${noteModel.dateTime.day} - ${noteModel.dateTime.month + 1} - ${noteModel.dateTime.year}',
                      style:
                          TextStyle(fontSize: 20, color: Colors.grey.shade400)),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Text(
                      noteModel.contenu,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade600),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 11),
                      child: noteModel.imagePath.isEmpty
                          ? Container()
                          : ImageElement(
                              imagePath: noteModel.imagePath,
                              width: 350,
                            )),
                ],
              ),
            )));
  }
}
