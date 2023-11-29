import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreatePw extends StatefulWidget {
  final String email;
  final String birth;
  final String name;

  const CreatePw(this.email, this.name, this.birth);

  @override
  State<CreatePw> createState() => _CreatePwState();
}

class _CreatePwState extends State<CreatePw> {
  bool _isVisible = false;
  bool _isVisible_c = false;

  late String pw;
  late String pw_confirm;

  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
              child: Column(
            children: [
              Container(
                height: 700,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Text('최소8자리 영문자및숫자와 특수문자 포함하여 비밀번호를 생성하세요.',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                      SizedBox(height: 50),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Email",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(230, 211, 211, 0.267))),
                          fillColor: Color.fromRGBO(230, 211, 211, 0.267),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(230, 211, 211, 0.267))),
                        ),
                        readOnly: true,
                        initialValue: widget.email,
                      ),
                      SizedBox(height: 30),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text('비밀번호',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      TextFormField(
                        maxLength: 12,
                        controller: _controller,
                        obscureText: !_isVisible,
                        decoration: InputDecoration(
                          hintText: '비밀번호를 입력하세요.',
                          suffixIcon: IconButton(
                              icon: Icon(_isVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () => setState(() {
                                    _isVisible = !_isVisible;
                                  })),
                        ),
                        style: TextStyle(fontSize: 18),
                        validator: (value) {
                          RegExp exp = RegExp(
                              r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$');
                          if (!value!.isEmpty) {
                            if (exp.hasMatch(value)) {
                              pw = value;
                              return null;
                            } else {
                              return "비밀번호를 다시 입력하세요.";
                            }
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.always,
                      ),
                      SizedBox(height: 30),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text('비밀번호 확인',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      TextFormField(
                        controller: _controller2,
                        maxLength: 12,
                        obscureText: !_isVisible_c,
                        decoration: InputDecoration(
                          hintText: '비밀번호를 확인하세요.',
                          suffixIcon: IconButton(
                              icon: Icon(_isVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () => setState(() {
                                    _isVisible_c = !_isVisible_c;
                                  })),
                        ),
                        style: TextStyle(fontSize: 18),
                        validator: (value) {
                          if (!value!.isEmpty) {
                            if (pw == value) {
                              pw_confirm = value;
                              return null;
                            } else {
                              return "비밀번호 불일치.";
                            }
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.always,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        child: const Text('다음'),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
