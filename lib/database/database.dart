import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao/note_dao.dart';
import 'entities/note.dart';

part 'database.g.dart';

@Database(version: 2, entities: [Note])
abstract class AppDatabase extends FloorDatabase {
  NoteDAO get noteDao;
}

// create migration
final migration1to2 = Migration(1, 2, (database) async {
  await database.execute('ALTER TABLE Note ADD COLUMN isFavorite INTEGER');
});


