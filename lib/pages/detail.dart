import 'package:flutter/material.dart';
import 'package:notepad/database/dao/note_dao.dart';
import 'package:notepad/database/database.dart';
import 'package:notepad/database/entities/note.dart';

import '../note_model.dart';

class Detail extends StatefulWidget {
  static const String routeName = '/detail';
  Detail({Key key}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  bool isEditing;
  TextEditingController _titleFieldController = TextEditingController();
  TextEditingController _noteFieldController = TextEditingController();
  NoteDAO noteDao;
  Note note;

  @override
  void initState() {
    initDB();
    super.initState();
  }

  initDB() async {
    final database = await $FloorAppDatabase
        .databaseBuilder('app_database.db')
        .addMigrations([migration1to2]).build();
    noteDao = database.noteDao;
  }

  @override
  Widget build(BuildContext context) {
    NoteModel noteModel = ModalRoute.of(context).settings.arguments;
    isEditing = noteModel.isEditing;
    note = noteModel.note;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Color.fromRGBO(216, 221, 240, 1),
              borderRadius: BorderRadius.circular(8)),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        actions: <Widget>[
          isEditing
              ? IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () async {
                    Note note = Note(
                      title: _titleFieldController.text,
                      note: _noteFieldController.text,
                      isFavorite: false,
                      dateTime: DateTime.now().toString(),
                    );
                    await noteDao.insertNote(note);
                    print('note saved');
                    Navigator.pop(context);
                  })
              : Container()
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(top: 80),
            color: Colors.white,
            child: Container(
              padding: EdgeInsets.only(
                top: 16,
                left: 16,
                right: 16,
              ),
              color: Color.fromRGBO(216, 221, 240, .4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: !isEditing
                        ? Text(
                            '${note.title}',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: TextField(
                              controller: _titleFieldController,
                              autocorrect: false,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                    left: 8,
                                  )),
                            ),
                          ),
                  ),
                  Divider(
                    color: Theme.of(context).accentColor.withOpacity(.9),
                  ),
                  Container(
                    child: !isEditing
                        ? Text(
                            '${note.note}',
                          )
                        : Container(
                            height: 250,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextFormField(
                              controller: _noteFieldController,
                              autocorrect: false,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 4),
                              ),
                            ),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 28.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('${!isEditing ? note.dateTime : ''}'),
                        Row(
                          children: <Widget>[
                            Icon(Icons.image),
                            Icon(Icons.mic),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
