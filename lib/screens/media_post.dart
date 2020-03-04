import 'package:flutter/material.dart';
//import 'package:iconnect/widgets/course_post.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:iconnect/widgets/uploader.dart';

class MediaPost extends StatefulWidget {
  @override
  _MediaPostState createState() => _MediaPostState();
}

class _MediaPostState extends State<MediaPost> {
  String inputText;
  //CoursePost addNewPost = CoursePost();

  File _imageFile;
  bool show = false;

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              hintText: 'Enter post here...',
            ),
            onChanged: (value) {
              inputText = value;
            },
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Color(0xFF79bda0),
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: FlatButton(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  child: Text(
                    'Image',
                    style: TextStyle(
                      color: Color(0xFF79bda0),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Color(0xFF79bda0),
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: FlatButton(
                  onPressed: () {},
                  child: Text(
                    'Document',
                    style: TextStyle(
                      color: Color(0xFF79bda0),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40.0,
          ),
          RaisedButton(
            color: Color(0xFF79bda0),
            onPressed: () {
              setState(() {
                show = !show;
              });
            },
            child: Text(
              'Sumbit',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          show
              ? Uploader(
                  file: _imageFile,
                )
              : Text(''),
        ],
      ),
    );
  }
}
