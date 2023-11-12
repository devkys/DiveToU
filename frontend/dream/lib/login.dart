import 'package:flutter/material.dart';



class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                Container(
                  height: 600,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.amber,
                  child: const Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        Text('Login',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                        )),
                        SizedBox(height: 30),
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
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text('회원가입하기', style: TextStyle(fontSize: 15))
                        ),
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