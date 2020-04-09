import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iconnect/models/course_idMap.dart';
import 'media_post.dart';
import 'package:iconnect/widgets/course_review.dart';
import 'package:iconnect/widgets/navbar_widget.dart';

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
  final firestore = Firestore.instance;
  List<String> courseReviewList = [];
  bool isReview = true;
  bool isPost = false;
  List<CoursePostModel> coursePostModelList = [];
  String currReviewsID;

  void getCourseReviews() async {
    CourseIdMap idMap = CourseIdMap();
    currReviewsID = idMap.ids[widget.courseId];
    final reviews = await firestore
        .collection('courses')
        .document(currReviewsID)
        .collection('review')
        .getDocuments();
    for (var review in reviews.documents) {
      courseReviewList.add(review.data['text']);
    }
    setState(() {});
  }

  void getCoursePost() async {
    CourseIdMap idMap = CourseIdMap();
    String currID = idMap.ids[widget.courseId];
    final posts = await firestore
        .collection('courses')
        .document(currID)
        .collection('coursePosts')
        .getDocuments();
    for (var post in posts.documents) {
      coursePostModelList.add(CoursePostModel(
        text: post.data['text'] ?? "",
        imgUrl: post.data['attach'] ?? "",
      ));
    }
    setState(() {});
  }

  Future<void> addFollow() async {
    //firebaseAuth current login user
    //Add collection for each user of followed courses.
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('You are following ${widget.courseName}'),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCourseReviews();
    getCoursePost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                    textColor: Colors.white,
                    onPressed: () {
                      addFollow();
                    },
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
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
                    decoration: BoxDecoration(
                      //border: Border.all(color: Colors.black, width: 1.0),
                      color: Color(0xffCBD2D4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          height: 35.0,
                          width: 150.0,
                          decoration: BoxDecoration(
                            boxShadow: isPost
                                ? [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 5.0,
                                    ),
                                  ]
                                : null,
                            color:
                                !isPost ? Color(0xffCBD2D4) : Color(0xFFe4edec),
                            borderRadius:
                                isPost ? BorderRadius.circular(5.0) : null,
                          ),
                          child: FlatButton(
                            child: Text(
                              'Post',
                            ),
                            onPressed: () {
                              setState(() {
                                coursePostModelList.clear();
                                isReview = false;
                                isPost = true;
                              });
                              getCoursePost();
                            },
                          ),
                        ),
                        Container(
                          height: 35.0,
                          width: 150.0,
                          decoration: BoxDecoration(
                            color: !isReview
                                ? Color(0xffCBD2D4)
                                : Color(0xFFe4edec),
                            borderRadius:
                                isReview ? BorderRadius.circular(5.0) : null,
                            boxShadow: isReview
                                ? [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 5.0,
                                    ),
                                  ]
                                : null,
                          ),
                          child: FlatButton(
                            child: Text('Reviews'),
                            onPressed: () {
                              setState(() {
                                isReview = true;
                                isPost = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: isReview
                        ? CourseReview(
                            reviewList: courseReviewList,
                            currID: currReviewsID,
                          )
                        : Container(
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 20),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Icon(Icons.comment),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(coursePostModelList[index]
                                                    .text ??
                                                " "),
                                          ],
                                        ),
                                        Image(
                                              height: 300,
                                              width: 300,
                                              image: NetworkImage(
                                                  coursePostModelList[index]
                                                      .imgUrl),
                                            ) ??
                                            Text(""),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              itemCount: coursePostModelList.length,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: NavbarWidget(plusButtonTask: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Container(
                      height: 500.0,
                      child: MediaPost(
                        id: currReviewsID,
                      ),
                    ),
                  ),
                ),
                isScrollControlled: true,
              );
            }),
          )
        ],
      ),
    );
  }
}

class CoursePostModel {
  String text;
  String imgUrl;

  CoursePostModel({
    this.text,
    this.imgUrl,
  });
}
