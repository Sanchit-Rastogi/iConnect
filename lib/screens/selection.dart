import 'package:flutter/material.dart';

class SelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                  child: Text('Instructor Section'),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/instructor');
                  }),
              RaisedButton(
                child: Text('Course Section'),
                onPressed: () {
                  Navigator.of(context).pushNamed('/course');
                },
              ),
              RaisedButton(
                child: Text('Club Section'),
                onPressed: () {
                  Navigator.of(context).pushNamed('/clubs');
                },
              ),
              RaisedButton(
                child: Text('Major Section'),
                onPressed: () {
                  Navigator.of(context).pushNamed('/major');
                },
              ),
              RaisedButton(
                child: Text('Ads Screen'),
                onPressed: () {
                  Navigator.of(context).pushNamed('/ads');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
