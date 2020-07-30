import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao/note_dao.dart';
import 'entities/note.dart';

part 'database.g.dart';

@Database(version: 1, entities: [Note])
abstract class AppDatabase extends FloorDatabase {
  NoteDAO get noteDao;
}


