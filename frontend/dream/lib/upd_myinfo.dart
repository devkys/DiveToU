import 'dart:convert';
import 'dart:io';

import 'package:dream/login.dart';
import 'package:flutter/cupertino.dart';
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

  late String userInfo = "";

  bool isChecked = false;
  String postId = Uuid().v4();


  final ImagePicker picker = ImagePicker();
  File? _image;

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _asyncMethod();
  //   });
  //   print(userInfo);
  //   UserAvatar();
  // }

  _asyncMethod() async {

    // ! is can not be null. (null check)
    userInfo = (await storage.read(key: "user_info"))!;

    if (userInfo == null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    }
  }


  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      print(_image);
      print(_image!.path);
    }
  }


  Future UserAvatar() async {
    Uri user_image_uri =
        Uri.http('localhost:3000', 'api/users/avatar', {'email': userInfo});
    try {
      var res = await http.get(
        user_image_uri,
        headers: {'Content-Type': 'application/json; charset-UTF-8'},
      );
      // if(res.statusCode == 200) {
      //   print(res);
      // }
    } catch (e) {
      print(e);
    }
  }

  Future update(String user_email, String image_path) async {
    final upd_userInfo_uri = Uri.parse('http://localhost:3000/api/user/upd');

    try {
      var res = await http.post(upd_userInfo_uri,
          headers: {'Content-Tyep': 'application/json; charset=UTF-8'},
          body: jsonEncode(
              {'user_email': user_email, 'img_path': image_path})); //post
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
              onPressed: () {
                // ! is can not be null.
                update(userInfo, _image!.path);

              })
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
              Container(
                height: 100.0,
                width: 100.0,
                child: DecoratedBox(
                    child: IconButton(
                        icon: Icon(Icons.edit),
                        hoverColor: Colors.grey.withOpacity(0.3),
                        onPressed: () {
                          getImage(ImageSource.gallery);
                        }),
                    decoration: 
                      _image != null ?
                         BoxDecoration(
                            borderRadius: BorderRadius.circular(18.0),
                            image: DecorationImage(
                              image: FileImage(_image!),
                                fit: BoxFit.fill)
                                )
                        : BoxDecoration(
                            borderRadius: BorderRadius.circular(18.0),
                            color: Colors.grey)
                            ),
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
              ),
              SizedBox(height: 40),
              Align(
                alignment: Alignment.topLeft,
                // child: Text('내 계정 비공개하기', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text('내 계정 비공개 하기', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  CupertinoSwitch(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },
                    activeColor: CupertinoColors.activeBlue,
                  )
                ]),
              ),

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
