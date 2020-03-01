import 'package:flutter/material.dart';

class CourseReview extends StatelessWidget {
  final List<String> reviewList;
  CourseReview({this.reviewList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.comment),
          title: Text(reviewList[index]),
        );
      },
      itemCount: reviewList.length,
    );
  }
}
