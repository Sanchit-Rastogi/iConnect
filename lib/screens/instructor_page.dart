import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:iconnect/widgets/navbar_widget.dart';
import 'package:iconnect/models/instructor_idMap.dart';

class InstructorPage extends StatefulWidget {
  final String instructorName;
  final String instructorId;
  final String instructorEmail;
  final String instructorGender;
  InstructorPage({
    this.instructorName,
    this.instructorId,
    this.instructorEmail,
    this.instructorGender,
  });

  @override
  _InstructorPageState createState() => _InstructorPageState();
}

class _InstructorPageState extends State<InstructorPage> {
  final firestore = Firestore.instance;
  List<String> instructorReviewList = [];
  var indexNum;
  String newReview;

  List<String> reviewList = [];

  void getInstructorReviews() async {
    InstructorIdMap idMap = InstructorIdMap();
    String currID = idMap.ids[widget.instructorId];
    final reviews = await firestore
        .collection('instructors')
        .document(currID)
        .collection('review')
        .getDocuments();
    for (var review in reviews.documents) {
      reviewList.add(review.data['text']);
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInstructorReviews();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: AutoSizeText(
          widget.instructorName,
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
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 9,
            child: Container(
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
                              widget.instructorId,
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
                                widget.instructorName,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Text(
                              widget.instructorGender,
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              'Email: ${widget.instructorEmail}',
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
                    height: 40.0,
                  ),
                  Container(
                    width: 900,
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                      color: Colors.white,
                    ),
                    child: Text(
                      'Reviews',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: 'Write your review here...',
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              newReview = value;
                            },
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            setState(() {
                              reviewList.add(newReview);
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
                          title: Text(reviewList[index]),
                        );
                      },
                      itemCount: reviewList.length,
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: NavbarWidget(),
          )
        ],
      ),
    );
  }
}
