import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class Uploader extends StatefulWidget {
  final File file;
  Uploader({this.file});

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage = FirebaseStorage(
      storageBucket: 'gs://iconnect-5c61c.appspot.com/CoursePost');

  StorageUploadTask _uploadTask;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startUpLoad();
  }

  void startUpLoad() {
    String filePath = '${DateTime.now()}.png';
    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      return StreamBuilder<StorageTaskEvent>(
        stream: _uploadTask.events,
        builder: (context, snapshot) {
          var event = snapshot?.data?.snapshot;
          double progressPercent =
              event != null ? event.bytesTransferred / event.totalByteCount : 0;
          return Column(
            children: [
              if (_uploadTask.isComplete) Text('Post Uploaded!'),
              LinearProgressIndicator(
                value: progressPercent,
              ),
              Text('${(progressPercent * 100).toStringAsFixed(1)} %'),
            ],
          );
        },
      );
    } else {
      return Column(
        children: <Widget>[
          Text('Try Again!'),
          Image.file(
            widget.file,
            width: 200,
            height: 140,
          ),
        ],
      );
    }
  }
}
