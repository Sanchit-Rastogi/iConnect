import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RequestAdPage extends StatefulWidget {
  @override
  _RequestAdPageState createState() => _RequestAdPageState();
}

class _RequestAdPageState extends State<RequestAdPage> {
  final _formKey = GlobalKey<FormState>();
  String dropdownValue = 'One Week';
  String categoryValue = 'Event';
  String businessName;
  String description;
  DateTime selectedDate;
  final firestore = Firestore.instance;
  List<String> adsCategories = [];
  File adImage;
  String imageFileURL;

  void getData() async {
    final ads = await firestore.collection('Ads_Category').getDocuments();
    for (var ad in ads.documents) {
      adsCategories.add(ad.data['text']);
    }
    setState(() {});
  }

  Future<void> _pickImage() async {
    File selected = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      adImage = selected;
    });
    saveImage(adImage);
  }

  void saveImage(File image) async {
    String filePath = '${DateTime.now()}.png';
    StorageReference ref = FirebaseStorage.instance.ref().child(filePath);
    StorageUploadTask uploadTask = ref.putFile(image);
    imageFileURL = (await (await uploadTask.onComplete).ref.getDownloadURL());
  }

  void uploadData() async {
    await firestore.collection('Category_Ads').add({
      'AdPicture': imageFileURL,
      'Category': categoryValue,
      'date': selectedDate,
      'Description': description,
      'businessName': businessName,
      'duration': dropdownValue,
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = Padding(
      padding: EdgeInsets.only(bottom: 40.0),
    );

    final pageTitle = Container(
      child: Text(
        "Tell us about your business!",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 35.0,
        ),
      ),
    );

    final formFieldSpacing = SizedBox(
      height: 30.0,
    );
    final registerForm = Padding(
      padding: EdgeInsets.only(top: 30.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _buildFormField('Business name', LineIcons.suitcase),
            formFieldSpacing,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Icon(
                    LineIcons.align_center,
                    color: Colors.black38,
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: categoryValue,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black38,
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        categoryValue = newValue;
                      });
                    },
                    underline: Container(
                      color: Colors.black38,
                      height: 1,
                    ),
                    items: adsCategories.map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ],
            ),
            formFieldSpacing,
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              height: 60.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.green[200],
              ),
              child: FlatButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(
                      LineIcons.file_picture_o,
                      color: Colors.white,
                    ),
                    Text(
                      'Add your AD picture',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  _pickImage();
                },
              ),
            ),
            formFieldSpacing,
            _buildDescriptionField('Add a description', LineIcons.file_text),
            formFieldSpacing,
          ],
        ),
      ),
    );

    final datepicker = IconButton(
      icon: Icon(LineIcons.calendar),
      onPressed: () {
        DatePicker.showDatePicker(context,
            showTitleActions: true,
            minTime: DateTime(2000, 1, 1),
            maxTime: DateTime(2020, 12, 31), onChanged: (date) {
          print('change $date');
        }, onConfirm: (date) {
          selectedDate = date;
        }, currentTime: DateTime.now(), locale: LocaleType.en);
      },
    );

    final duration = DropdownButton<String>(
      value: dropdownValue,
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.grey),
      underline: Container(
        height: 2,
        color: Colors.black,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['One Week', 'Two Weeks', 'One Month']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );

    Future<bool> handleError() {
      return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('Please fill the complete form'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                ],
              );
            },
          ) ??
          false;
    }

    final submitBtn = Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Container(
        margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
        height: 60.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          border: Border.all(color: Colors.white),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(7.0),
          color: Colors.green[200],
          elevation: 10.0,
          shadowColor: Colors.white70,
          child: MaterialButton(
            onPressed: () {
              if (description == null || businessName == null) {
                handleError();
              } else {
                uploadData();
                Navigator.pop(context);
              }
            },
            child: Text(
              'SUBMIT REQUEST',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 40.0),
          child: Column(
            children: <Widget>[
              appBar,
              Container(
                padding: EdgeInsets.only(left: 30.0, right: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    pageTitle,
                    registerForm,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        datepicker,
                        duration,
                      ],
                    ),
                    submitBtn,
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormField(String label, IconData icon) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black),
        prefixIcon: Icon(
          icon,
          color: Colors.black38,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black38),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
        ),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      onChanged: (newValue) {
        businessName = newValue;
      },
    );
  }

  Widget _buildDescriptionField(String label, IconData icon) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black),
        prefixIcon: Icon(
          icon,
          color: Colors.black38,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black38),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
        ),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      onChanged: (newValue) {
        description = newValue;
      },
      maxLines: 5,
    );
  }
}
