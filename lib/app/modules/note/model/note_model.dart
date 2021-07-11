class NoteModel {
  NoteModel(
      {required this.title,
      required this.dateTime,
      required this.contenu,
      required this.imagePath,
      this.id});

  String title;
  final DateTime dateTime;
  final String contenu;
  final String imagePath;
  final int? id;

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    var noteModel = new NoteModel(
        id: json['_id'],
        title: json['title'],
        dateTime:
            new DateTime.fromMicrosecondsSinceEpoch(int.parse(json['date'])),
        contenu: json['contenu'],
        imagePath: json['image_path']);
    return noteModel;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['title'] = this.title;
    data['date'] = this.dateTime.microsecondsSinceEpoch.toString();
    data['contenu'] = this.contenu;
    data['image_path'] = this.imagePath;
    return data;
  }
}
