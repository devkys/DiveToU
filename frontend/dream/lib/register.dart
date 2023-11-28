import 'dart:convert';
import 'package:dream/createpw.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dream/login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController datecontroll = TextEditingController();
  // TextEditingController emailcontroll = TextEditingController();
  // TextEditingController namecontroll = TextEditingController();
  late String email;
  late String name;
  late String birth;
  // RegisterDTO registerDTO = RegisterDTO("", "", "", "");

  Uri uri = Uri.parse("http://localhost:3000/auth/signup");
  Uri emailcheck_uri = Uri.parse("http://localhost:3000/auth/duplicated_check");

  Future register() async {
    var res = await http.post(
      uri,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      // body: jsonEncode({'email': registerDTO.email, 'password': registerDTO.pw, 'name' : registerDTO.name, 'birth' : registerDTO.birth})
    );
  }

  // 이메일 중복 체크
  Future EmailCheck() async {
    try {
      var res = await http.post(emailcheck_uri,
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode({'email': email}));
      print(res.body);

      if (res.body.toString() == 'false') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreatePw(email, name, birth)));

        print(email);
        print(name);
        print(birth);
      } else {
        Fluttertoast.showToast(
            msg: '이미 존재하는 이메일',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 10);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    datecontroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var dateTime = DateTime.now();
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                Container(
                  height: 700,
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.amber,
                  child: Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        Text('계정을 생성하세요',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),

                        SizedBox(height: 50),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            '이름',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextFormField(
                          style: TextStyle(fontSize: 18, color: Colors.red),
                          // controller: TextEditingController(text: registerDTO.name),
                          autovalidateMode: AutovalidateMode.always,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "이름을 입력하세요";
                            } else {
                              name = value;
                            } 
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text('Email',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                        TextFormField(
                          style: TextStyle(fontSize: 18, color: Colors.red),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "이메일을 입력해주세요";
                            } else if (!EmailValidator.validate(
                                value.toString())) {
                              return "이메일 형식을 맞춰주세요";
                            } else {
                              return null;
                            }
                          },
                          // controller: TextEditingController(text: registerDTO.email),
                        ),
                        SizedBox(height: 30),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text('생년월일',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                        TextFormField(
                          onTap: () {
                            showCupertinoModalPopup(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.4,
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  "취소",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                )),
                                            TextButton(
                                                child: Text('설정'),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  datecontroll.text =
                                                      DateFormat.yMd()
                                                          .format(dateTime);
                                                  birth = datecontroll.text;
                                                }),
                                          ],
                                        ),
                                        Expanded(
                                          child: CupertinoDatePicker(
                                            initialDateTime: dateTime,
                                            mode: CupertinoDatePickerMode.date,
                                            onDateTimeChanged:
                                                (DateTime newDate) {
                                              setState(() {
                                                dateTime = newDate;
                                              });
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                });
                          },
                          controller: datecontroll,
                        ),
                        SizedBox(height: 30),
                       
                        ElevatedButton(
                          child: const Text('다음'),
                          onPressed: () async {
                            EmailCheck();
                          },
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            child: Text("로그인하기", style: TextStyle()),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
