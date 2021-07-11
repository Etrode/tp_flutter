import 'package:flutter/material.dart';
import 'package:tp_flutter/app/modules/note/model/note_model.dart';
import 'package:tp_flutter/app_routes.dart';
import 'image_element.dart';

class ListElement extends StatelessWidget {
  const ListElement({required this.element});
  final NoteModel element;

  void navigateToNoteDetailsScreen(context, NoteModel noteModel) {
    Navigator.pushNamed(context, kNoteDetailsRoute, arguments: element);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => navigateToNoteDetailsScreen(context, element),
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${element.title} # ${element.id} ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                    '${element.dateTime.day} - ${element.dateTime.month + 1} - ${element.dateTime.year}',
                    style:
                        TextStyle(fontSize: 15, color: Colors.grey.shade400)),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 11),
                  child: Text(
                    element.contenu,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 11),
                    child: element.imagePath.isEmpty
                        ? Container()
                        : ImageElement(
                            imagePath: element.imagePath,
                            width: 350,
                          )),
                Divider(),
              ],
            ),
          )),
    );
  }
}
