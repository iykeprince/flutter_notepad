import 'package:floor/floor.dart';

@entity
class Note {
  @primaryKey
  final int id;
  final String title;
  final String note;
  bool isFavorite;
  final String dateTime;

  Note(this.id, this.title, this.note, this.isFavorite, this.dateTime);
}
