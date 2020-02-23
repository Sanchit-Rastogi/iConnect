import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CoursePage extends StatefulWidget {
  final String courseName;
  final String courseId;
  final String courseLab;
  final num courseCredit;
  CoursePage({
    this.courseName,
    this.courseId,
    this.courseCredit,
    this.courseLab,
  });

  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: AutoSizeText(
          widget.courseName,
          style: TextStyle(color: Colors.black),
          maxLines: 1,
        ),
        centerTitle: true,
        leading: FlatButton(
          child: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        //padding: EdgeInsets.all(20.0),
        color: Color(0xFFe4edec),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Material(
                    elevation: 10.0,
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      child: Text(
                        widget.courseId,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      backgroundColor: Colors.white,
                      radius: 50.0,
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          widget.courseName,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Text(
                        'Lab: ${widget.courseLab}',
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'Credit hours: ${widget.courseCredit}',
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            RaisedButton(
              child: Text('Follow'),
              color: Color(0xFF79bda0),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
              textColor: Colors.white,
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
                side: BorderSide(
                  color: Color(0xFF79bda0),
                ),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.0),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FlatButton(
                    child: Text('Post'),
                    onPressed: () {},
                    color: Colors.white,
                  ),
                  FlatButton(
                    child: Text('Reviews'),
                    onPressed: () {},
                    color: Colors.white,
                    highlightColor: Color(0xFFe4edec),
                  ),
                  FlatButton(
                    child: Text('Media'),
                    onPressed: () {},
                    color: Colors.white,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
