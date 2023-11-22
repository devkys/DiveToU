import 'package:dream/createpw.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dream/login.dart';
import 'package:intl/intl.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  TextEditingController datecontroll = TextEditingController();

  // void initState() {
  //   var dateTime = DateTime.now();
  //   super.initState();

  // }

  @override
  void dispose(){
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
                            if(value!.isEmpty) {
                              return "이메일을 입력해주세요";
                            } else if (!EmailValidator.validate(value.toString())) {
                              return "이메일 형식을 맞춰주세요";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 30
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text('생년월일',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                        TextFormField(onTap: () {
                          showCupertinoModalPopup(
                              context: context,
                              builder: (context) {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("취소", style: TextStyle(
                                                color: Colors.red
                                              ),)),
                                          TextButton(
                                              child: Text('설정'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                datecontroll.text = DateFormat.yMd().format(dateTime);
                                              }),
                                        ],
                                      ),
                                      Expanded(
                                        child: CupertinoDatePicker(
                                          initialDateTime: dateTime,
                                          mode: CupertinoDatePickerMode.date,
                                          onDateTimeChanged: (DateTime newDate) {
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreatePw()),
                              );
                          } 
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
