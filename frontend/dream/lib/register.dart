import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dream/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  void initState() {
    var dateTime = DateTime.now();
    super.initState();
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
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(height: 50),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            '이름',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextField(
                          style: TextStyle(fontSize: 15, color: Colors.red),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text('Email',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                        ),
                        TextField(
                          style: TextStyle(fontSize: 15, color: Colors.red),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text('생년월일',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                        ),
                        TextField(onTap: () {
                          showCupertinoModalPopup(
                              context: context,
                              builder: (context) {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  child: Column(
                                    // crossAxisAlignment:
                                    //     CrossAxisAlignment.center,
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("취소")),
                                          TextButton(
                                              child: Text('설정'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              }),
                                        ],
                                      ),
                                      Expanded(
                                        child: CupertinoDatePicker(
                                          initialDateTime: new DateTime.now(),
                                          mode: CupertinoDatePickerMode.date,
                                          onDateTimeChanged: (date) {
                                            setState(() {
                                              dateTime = date;
                                            });
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              });
                        }),
                        SizedBox(height: 30),
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
