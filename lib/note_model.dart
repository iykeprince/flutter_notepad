import 'database/entities/note.dart';

class NoteModel {
  final int id;
  final Note note;
  final bool isEditing;

  NoteModel({
    this.id,
    this.note,
    this.isEditing,
  });
}
