import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class MyInfo extends StatefulWidget {
  const MyInfo({super.key});

  @override
  State<MyInfo> createState() => _MyInfoState();
}

class _MyInfoState extends State<MyInfo> {
  static final storage = new FlutterSecureStorage();

  late String? userInfo;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    userInfo = await storage.read(key: "user_info");

    // if (userInfo == null) {
    //   Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    // }
  }

  final ImagePicker picker = ImagePicker();
  XFile? _image;

  var uuid = Uuid();

  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path);
        print(_image);
      });
    }
  }

  Future UserAvatar() async {
    final user_image_uri =
        Uri.http('localhost:3000', 'api/users/avatar', {'email': userInfo});
    try {
      var res = await http.get(
        user_image_uri,
        headers: {'Content-Type': 'application/json; charset-UTF-8'},
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('프로필 수정'),
        centerTitle: false,
        elevation: 0.0,
        actions: [
          TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                padding: EdgeInsets.all(16.0),
                textStyle:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
              ),
              child: Text('저장하기'),
              onPressed: () {})
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(children: [
              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 100.0,
                width: 100.0,
                child: DecoratedBox(
                    child: IconButton(
                        icon: Icon(Icons.edit),
                        hoverColor: Colors.grey.withOpacity(0.3),
                        onPressed: () {
                          getImage(ImageSource.gallery);
                        }),
                    decoration: _image != null
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(18.0),
                            image: DecorationImage(
                                // image: FileImage(_image!.path as File),
                                image: AssetImage(_image!.path),
                                fit: BoxFit.cover))
                        : BoxDecoration(
                            borderRadius: BorderRadius.circular(18.0),
                            color: Colors.grey)),
              ),
              SizedBox(height: 50),
              Align(
                alignment: Alignment.topLeft,
                child: Text('이름',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              TextFormField(
                decoration: InputDecoration(hintText: '이름을 입력하세요.'),
              ),
              SizedBox(height: 40),
              Align(
                alignment: Alignment.topLeft,
                child: Text('자기소개',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              TextField(
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(hintText: "자기소개를 입력하세요."),
              )
              // Align(
              //     alignment: Alignment.topLeft,
              //     child: Text('비밀번호',
              //         style: TextStyle(
              //             fontSize: 20, fontWeight: FontWeight.bold))),
              // TextFormField(
              //   decoration: InputDecoration(hintText: '비밀번호를 입력하세요.'),
              // ),
              // SizedBox(height: 40),
              // Align(
              //     alignment: Alignment.topLeft,
              //     child: Text('비밀번호 확인',
              //         style: TextStyle(
              //             fontSize: 20, fontWeight: FontWeight.bold))),
              // TextFormField(
              //   decoration: InputDecoration(hintText: '비밀번호를 입력하세요.'),
              // ),
            ]),
          ),
        ),
      ),
    );
  }
}
