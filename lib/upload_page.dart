import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sy_flutter_qiniu_storage/sy_flutter_qiniu_storage.dart';
import 'package:video_app_02/model/qiniu_model.dart';

class UploadPage extends StatefulWidget {
  UploadPage({Key key}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  String qiniu_token_url =
      'http://api.360inhands.com:8080/qiniu_token/token/get?bucket=dynamic-app-public';

  double _process = 0.0;

  pickVideo() async {
    File file = await ImagePicker.pickVideo(
        source: ImageSource.camera, maxDuration: const Duration(seconds: 10));
    print(file);

    Dio().get('path').then((response) async {
      QiniuToken qiniuToken = QiniuToken.fromJson(response.data);
      print(qiniuToken.token);

      final syStorage = new SyFlutterQiniuStorage();
      _process = 0.0;
      //监听上传进度
      syStorage.onChanged().listen((dynamic percent) {
        double p = percent;
        setState(() {
          _process = p;
        });
        print(percent);
      });

      String key = DateTime.now().millisecondsSinceEpoch.toString() +
          '.' +
          file.path.split('.').last;
      String token = qiniuToken.token;
      //上传文件
      bool result = await syStorage.upload(file.path, token, key);
      print(result); //true 上传成功，false失败
    });
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
