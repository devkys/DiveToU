
import 'package:flutter/material.dart';
import 'package:dream/login.dart';

class Register extends StatefulWidget {
   const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                  // color: Colors.amber,
                  child: Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        Text('계정을 생성하세요',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                        )),
                        SizedBox(height: 30),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text('이름',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                          TextField(
                          style: TextStyle(fontSize: 30, color: Colors.red),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text('Email',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                          )),
                        ),
                        TextField(
                          style: TextStyle(fontSize: 30, color: Colors.red),
                        ),
                        SizedBox(height: 30),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text('password',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                          )),
                        ),
                        TextField(
                          style: TextStyle(fontSize: 30, color: Colors.red),
                        ),
                         SizedBox(height: 30),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text('confirm password',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                          )),
                        ),
                        TextField(
                          style: TextStyle(fontSize: 30, color: Colors.red),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            child: Text("로그인하기", style: TextStyle()),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  Login()),
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