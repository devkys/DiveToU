import 'dart:convert';

import 'package:dream/LoginDTO.dart';
import 'package:dream/dashboard.dart';
import 'package:dream/register.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  LoginDTO loginDTO = LoginDTO("", "");
  Uri uri = Uri.parse("http://localhost:3000/auth/signin");

  Future login() async {
    var res = await http.post(
      uri,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({'email': loginDTO.email, 'password': loginDTO.pw})
    );

    if(res != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Board()));
    } else {
      return "이메일 혹은 비밀번호를 확인해주세요";
    }

  }

  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  height: 600,
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.amber,
                  child: Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        Text('로그인하기',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                        SizedBox(height: 80),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text('이메일',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                        TextField(
                          style: TextStyle(fontSize: 18, color: Colors.red),
                          controller: TextEditingController(text: loginDTO.email),
                          onChanged: (value) {
                            loginDTO.email = value;
                          },
                        ),
                        SizedBox(height: 50),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text('비밀번호',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                        TextField(
                          obscureText: !_isVisible,
                          decoration: InputDecoration(
                              // border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                  icon: Icon(_isVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: () => setState(() {
                                        _isVisible = !_isVisible;
                                      }))),
                          style: TextStyle(fontSize: 18, color: Colors.red),
                          controller: TextEditingController(text: loginDTO.pw),
                          onChanged: (value) {
                            loginDTO.pw = value;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          child: const Text('로그인'),
                          onPressed: () {
                            login();
                          },
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            child: Text("회원 가입하기", style: TextStyle()),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Register()),
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
