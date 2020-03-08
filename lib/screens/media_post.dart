import 'package:flutter/material.dart';
import 'package:iconnect/screens/course.dart';
import 'course.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class MediaPost extends StatefulWidget {
  List<String> posts;
  MediaPost({this.posts});

  @override
  _MediaPostState createState() => _MediaPostState();
}

class _MediaPostState extends State<MediaPost> {
  String inputText;
  File _imageFile;

  CoursePage coursePage = CoursePage();

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile = selected;
    });
  }

  void saveImage(File image) async {
    String filePath = '${DateTime.now()}.png';
    StorageReference ref = FirebaseStorage.instance.ref().child(filePath);
    StorageUploadTask uploadTask = ref.putFile(image);
    print(await (await uploadTask.onComplete).ref.getDownloadURL());
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
              saveImage(_imageFile);
              setState(() {
                widget.posts.add(inputText);
              });
              Navigator.pop(context);
            },
            child: Text(
              'Sumbit',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
