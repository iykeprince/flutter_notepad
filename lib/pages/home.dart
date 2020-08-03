import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:notepad/database/dao/note_dao.dart';
import 'package:notepad/database/database.dart';
import 'package:notepad/database/entities/note.dart';
import 'package:notepad/pages/detail.dart';

import '../note_model.dart';

List<Note> list = [];
NoteDAO noteDao;

class Home extends StatefulWidget {
  static const String routeName = '/home';
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _listItem(ctx, index) {
    Note note = list[index];
    NoteModel noteModel = new NoteModel(note: note, isEditing: false);
    DateTime dateTime = DateTime.parse(note.dateTime);
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.pushNamed(
              context,
              Detail.routeName,
              arguments: noteModel,
            );
          },
          title: Text(
            note.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).accentColor,
            ),
          ),
          subtitle: Text(
            note.note,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w300,
              color: Theme.of(context).accentColor,
            ),
          ),
          trailing: Container(
            width: 110,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    InkWell(
                      onTap: () async {
                        print('new isFavorite: ${note.isFavorite}');
                        note.isFavorite = !note.isFavorite;
                        print('new isFavorite: ${note.isFavorite}');
                        // await noteDao.updateNote(note, note.id);

                        note = await noteDao.getNoteById(note.id);
                        print('currrent note: $note');
                        setState(() {});
                      },
                      child: Icon(
                        note.isFavorite ? Icons.star : Icons.star_border,
                        color: Colors.orange,
                      ),
                    ),
                    Icon(
                      Icons.more_vert,
                    ),
                  ],
                ),
                Text(
                  '${DateFormat.yMEd().add_jms().format(dateTime)}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
        ),
        Divider(
          color: Theme.of(context).accentColor,
        ),
      ],
    );
  }

  @override
  void initState() {
    initDb();
    super.initState();
  }

  initDb() async {
    final database = await $FloorAppDatabase
        .databaseBuilder('app_database.db')
        .addMigrations([migration1to2]).build();
    noteDao = database.noteDao;

    // final note = Note();
    // await noteDao.insertNote(note);
  }

  Future<List<Note>> getNotes() async {
    return await noteDao.getNotes();
  }

  @override
  Widget build(BuildContext context) {
    list.clear();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'MyNotes',
          style: TextStyle(
            fontSize: 22,
            color: Theme.of(context).accentColor,
          ),
        ),
        actions: <Widget>[
          Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(216, 221, 240, 1),
                  borderRadius: BorderRadius.circular(8)),
              child: Icon(
                Icons.search,
                color: Theme.of(context).accentColor,
              )),
        ],
      ),
      body: FutureBuilder<List<Note>>(
        future: getNotes(),
        builder: (context, AsyncSnapshot<List<Note>> snapshot) {
          if (snapshot.hasData) {
            // snapshot.data.forEach((note) {
            //   list.add(note);
            // });
            list = snapshot.data;
            return Container(
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) => _listItem(context, index),
                scrollDirection: Axis.vertical,
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NoteModel noteModel = new NoteModel(
            id: list.length,
            isEditing: true,
          );
          Navigator.pushNamed(
            context,
            Detail.routeName,
            arguments: noteModel,
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
