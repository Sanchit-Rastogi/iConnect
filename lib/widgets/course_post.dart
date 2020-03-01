import 'package:flutter/material.dart';

class CoursePost extends StatelessWidget {
  final List<String> postList = [];

  void addPost(String value) {
    postList.add(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.comment),
          title: Text(postList[index]),
        );
      },
      itemCount: postList.length,
    ));
  }
}
