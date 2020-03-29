import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CourseReview extends StatefulWidget {
  final List<String> reviewList;
  final String currID;
  CourseReview({this.reviewList, this.currID});

  @override
  _CourseReviewState createState() => _CourseReviewState();
}

class _CourseReviewState extends State<CourseReview> {
  final _controller = TextEditingController();

  Firestore firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Write your review here...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  firestore
                      .collection('courses')
                      .document(widget.currID)
                      .collection('review')
                      .add({'text': _controller.value.text});
                  setState(() {
                    widget.reviewList.add(_controller.value.text);
                  });
                  _controller.clear();
                  FocusScope.of(context).unfocus();
                },
                child: Icon(Icons.send),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.comment),
                title: Text(widget.reviewList[index]),
              );
            },
            itemCount: widget.reviewList.length,
          ),
        ),
      ],
    );
  }
}
