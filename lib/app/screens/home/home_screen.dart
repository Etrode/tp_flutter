import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tp_flutter/app/modules/note/data/repository/note_repository.dart';
import 'package:tp_flutter/app/modules/note/model/note_model.dart';
import 'package:tp_flutter/app/screens/home/widgets/list_element.dart';
import 'dialog/camera_dialog.dart';
import 'widgets/image_element.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isAddingNote = false;
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateForm = AutovalidateMode.disabled;

  final _titreController = TextEditingController();
  final _contenuController = TextEditingController();

  // liste des cameras dans le device
  List<CameraDescription> cameras = [];

  //type de variable permettant de sauvegarder les données d'un image capturée
  String? capturedImage;

  final NoteRepository noteRepository = new NoteRepository();

  // Liste de notes à afficher
  List<NoteModel> lNotes = [];

  @override
  void initState() {
    retrieveNotes();
    super.initState();
  }

  retrieveNotes() async {
    var lNotesDb = await noteRepository.retrieve();
    setState(() {
      lNotes = lNotesDb;
    });
  }

  startAddingNote() {
    setState(() {
      isAddingNote = true;
    });
  }

  endAddingNote() {
    setState(() {
      isAddingNote = false;
    });
  }

  setCapturedImage(String? imagePath) {
    setState(() {
      capturedImage = imagePath;
    });
  }

  Future _showMyDialog() async {
    XFile? res = await showDialog(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          shape: CircleBorder(),
          child: Padding(
              padding: const EdgeInsets.all(8.0), child: CameraDialog()),
        );
      },
    );
    if (res != null) {
      setCapturedImage(res.path);
    }
  }

  void addNote() async {
    startAddingNote();
    // Ajout note dans le repo
    NoteModel noteModel = new NoteModel(
        title: _titreController.text,
        dateTime: DateTime.now(),
        contenu: _contenuController.text,
        imagePath: capturedImage == null ? "" : capturedImage!);

    noteRepository.insertNote(noteModel);
    retrieveNotes();
    endAddingNote();
    setState(() {
      _contenuController.text = '';
      _titreController.text = '';
      capturedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 11),
                child: Text(
                  'MES NOTES',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              isAddingNote
                  ? CircularProgressIndicator()
                  : Card(
                      shape: BeveledRectangleBorder(
                        side: BorderSide(
                          width: 0.5,
                        ),
                      ),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 11),
                        child: Form(
                          autovalidateMode: _autovalidateForm,
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: Text(
                                  "NOUVELLE NOTE",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.name,
                                  controller: _titreController,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    labelText: 'Titre',
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                      borderRadius:
                                          const BorderRadius.all(Radius.zero),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  controller: _contenuController,
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      labelText: 'Contenu',
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius:
                                            const BorderRadius.all(Radius.zero),
                                      )),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        shape: BeveledRectangleBorder(),
                                        backgroundColor: Colors.grey.shade800,
                                      ),
                                      onPressed: (capturedImage == null ||
                                              capturedImage!.isEmpty)
                                          ? _showMyDialog
                                          : setCapturedImage(null),
                                      child: Text(
                                        (capturedImage == null ||
                                                capturedImage!.isEmpty)
                                            ? 'Ajouter une image'
                                            : 'Supprimer l\'image',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                    (capturedImage == null ||
                                            capturedImage!.isEmpty)
                                        ? Container()
                                        : ImageElement(
                                            imagePath: capturedImage!,
                                            width: 100,
                                          )
                                  ],
                                ),
                              ),
                              Center(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    shape: BeveledRectangleBorder(),
                                    backgroundColor: Colors.grey.shade800,
                                  ),
                                  onPressed: addNote,
                                  child: Text(
                                    'AJOUTER MA NOTE',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 11),
                child: Text(
                  'MES NOTES SAUVEGARDÉES',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Column(
                children:
                    lNotes.map((note) => ListElement(element: note)).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
