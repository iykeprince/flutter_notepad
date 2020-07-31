import 'dart:async';
import 'package:flutter/material.dart';
import 'package:notepad/database/dao/note_dao.dart';
import 'package:notepad/database/database.dart';
import 'package:notepad/database/entities/note.dart';
import 'package:notepad/pages/detail.dart';

List<Note> list = [
  Note(
    1,
    'Notes from UI event',
    'Lorem ipsum dolor sit amet, conseletur sadpacing...',
    false,
    'Oct 25, 2019, 10:25',
  ),
  Note(
    2,
    'Material Design',
    'Material Design is a design language that Google developed in 2014. Expanding..',
    true,
    'Oct 25, 2019, 9:25',
  ),
  Note(
    3,
    'Meeting 20/10',
    'Lorem ipsum dolor sit amet, conseletur sadpacing...',
    false,
    'Oct 25, 2019, 10:25',
  ),
  Note(
    4,
    'Notes from client meeting',
    'Lorem ipsum dolor sit amet, conseletur sadpacing...',
    false,
    'Oct 25, 2019, 10:25',
  ),
  Note(
    5,
    'Report 100',
    'Lorem ipsum dolor sit amet, conseletur sadpacing...',
    true,
    'Oct 25, 2019, 10:25',
  ),
  Note(
    6,
    'Client email list',
    'Lorem ipsum dolor sit amet, conseletur sadpacing...',
    false,
    'Oct 25, 2019, 10:25',
  ),
  Note(
    7,
    'Notes from meeting 10/10',
    'Lorem ipsum dolor sit amet, conseletur sadpacing...',
    true,
    'Oct 25, 2019, 10:25',
  ),
  Note(
    8,
    'Notes from UI event',
    'Lorem ipsum dolor sit amet, conseletur sadpacing...',
    false,
    'Oct 25, 2019, 10:25',
  ),
  Note(
    9,
    'Notes from UI event',
    'Lorem ipsum dolor sit amet, conseletur sadpacing...',
    false,
    'Oct 25, 2019, 10:25',
  ),
  Note(
    10,
    'Notes from UI event',
    'Lorem ipsum dolor sit amet, conseletur sadpacing...',
    true,
    'Oct 25, 2019, 10:25',
  ),
];
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
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.pushNamed(
              context,
              Detail.routeName,
              arguments: false,
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
                        note.isFavorite = !note.isFavorite;
                        await noteDao.updateNote(note);

                        note = await noteDao.getNoteById(note.id);
                        print('currrent note: $note');
                        setState(() {});
                      },
                      child: Icon(
                        list[index].isFavorite ? Icons.star : Icons.star_border,
                        color: Colors.orange,
                      ),
                    ),
                    Icon(
                      Icons.more_vert,
                    ),
                  ],
                ),
                Text(
                  '${note.dateTime}',
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
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    noteDao = database.noteDao;

    // final note = Note();
    // await noteDao.insertNote(note);

    final result = await noteDao.getNotes();
    result.forEach((note) {
      list.add(note);
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body: Container(
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) => _listItem(context, index),
          scrollDirection: Axis.vertical,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            Detail.routeName,
            arguments: true,
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
