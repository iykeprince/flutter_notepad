import 'package:floor/floor.dart';
import 'package:notepad/database/entities/note.dart';

@dao
abstract class NoteDAO {
  @Query('SELECT * FROM Note')
  Future<List<Note>> getNotes();

  @Query('SELECT * FROM Note WHERE id = :id')
  Future<Note> getNoteById(int id);

  @insert
  Future<void> insertNote(Note note);

  // @update
  // Future<int> updateNote(Note note, int id);
}
