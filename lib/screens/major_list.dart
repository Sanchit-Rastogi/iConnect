import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iconnect/models/major_model.dart';
import 'package:iconnect/screens/major_page.dart';

class MajorList extends StatefulWidget {
  @override
  _MajorListState createState() => _MajorListState();
}

class _MajorListState extends State<MajorList> {
  final firestore = Firestore.instance;
  List<MajorModel> majorList = [];
  var indexNum;

  void getData() async {
    final majors = await firestore.collection('majors').getDocuments();
    for (var major in majors.documents) {
      majorList.add(MajorModel(
        id: major.data['id'],
        name: major.data['name'],
      ));
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  void sendName() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MajorPage(
        majorId: majorList[indexNum].id,
        majorName: majorList[indexNum].name,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Major',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          Icon(
            Icons.filter_list,
            color: Colors.black,
          ),
        ],
      ),
      body: Container(
        color: Color(0xFFe4edec),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.black),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(10.0),
                leading: Material(
                  elevation: 10.0,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    child: Text(
                      majorList[index].id,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    backgroundColor: Colors.white,
                    radius: 25.0,
                  ),
                ),
                title: Text(
                  majorList[index].name,
                  style: TextStyle(color: Colors.black),
                ),
                trailing: FlatButton(
                  child: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    setState(() {
                      indexNum = index;
                    });
                    sendName();
                  },
                ),
              ),
            );
          },
          itemCount: majorList.length,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: Row(
          children: <Widget>[
            FlatButton(
              onPressed: () {},
              child: Icon(Icons.home),
            ),
            FlatButton(
              onPressed: () {},
              child: Icon(Icons.search),
            ),
            FlatButton(
              onPressed: () {},
              child: Icon(Icons.notifications),
            ),
            FlatButton(
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
              onPressed: () {},
              child: Icon(Icons.perm_identity),
            ),
          ],
        ),
      ),
    );
  }
}
