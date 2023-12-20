import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class MyInfo extends StatefulWidget {
  const MyInfo({super.key});

  @override
  State<MyInfo> createState() => _MyInfoState();
}

class _MyInfoState extends State<MyInfo> {
  XFile? _image;
  bool? result;
  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if(pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path);
      });
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
              SizedBox(
                height: 100.0,
                width: 100.0,
                child: DecoratedBox(
                  child: IconButton(
                      icon: Icon(Icons.edit),
                      hoverColor: Colors.grey.withOpacity(0.3),
                      onPressed: () {
                        getImage(ImageSource.gallery);
                        if(_image != null)  {
                          result = true;
                        } else {
                          result = false;

                        }
                      }),
                  decoration: 
                  BoxDecoration(
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