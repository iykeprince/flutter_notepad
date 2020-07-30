import 'package:floor/floor.dart';
import 'package:notepad/database/entities/note.dart';

@dao
abstract class NoteDAO {
  @Query('SELECT * FROM Note')
  Future<List<Note>> getNotes();

  @Query('SELECT * FROM Note WHERE id = :id')
  Stream<Note> getNoteById(int id);

  @insert
  Future<void> insertNote(Note note);
}
