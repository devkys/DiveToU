import 'package:dream/register.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';



class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final Uri _url = Uri.parse('https://flutter.dev');
  bool _isVisible = false;
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
                  // color: Colors.amber,
                  child: Padding(
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
                          obscureText: !_isVisible,
                          decoration: InputDecoration(
                            // border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(_isVisible ? Icons.visibility_off : Icons.visibility),
                              onPressed: () => setState(() {
                                _isVisible = !_isVisible;
                              })
                            )
                          ),
                          style: TextStyle(fontSize: 30, color: Colors.red),
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
                                MaterialPageRoute(builder: (context) =>  Register()),
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