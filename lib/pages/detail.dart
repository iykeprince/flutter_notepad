import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  static const String routeName = '/detail';
  Detail({Key key}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  bool isEditing = false;
  TextEditingController _titleFieldController = TextEditingController();
  TextEditingController _noteFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // isEditing = ModalRoute.of(context).settings.arguments;
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
            onPressed: () {},
          ),
        ),
        actions: <Widget>[IconButton(icon: Icon(Icons.check), onPressed: null)],
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: isEditing
                        ? Text(
                            'Google Meeting 10/20',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Container(
                            height: 60,
                            child: TextFormField(
                              controller: _titleFieldController,
                              autocorrect: false,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                              ),
                            ),
                          ),
                  ),
                  Divider(
                    color: Theme.of(context).accentColor.withOpacity(.9),
                  ),
                  Container(
                    child: isEditing
                        ? Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
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
                        Text('Oct 10, 2020 10:20'),
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
