import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadPage extends StatefulWidget {
  UploadPage({Key key}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {

  pickVideo() async {
    File file = await ImagePicker.pickVideo(
          source: ImageSource.camera, maxDuration: const Duration(seconds: 10));
    print(file);
  }

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('上传作品'),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                icon: Icon(Icons.title),
                labelText: "给你的作品一个标题吧",
              ),
            ),
            Container(
              height: 150,
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage('assets/images/cloud_upload.png'),
                  fit: BoxFit.contain,
                ),
              ),
              alignment: Alignment.centerLeft,
              child: FlatButton(
                onPressed: () {
                  pickVideo();
                },
                child: Text('上传作品'),
                color: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}