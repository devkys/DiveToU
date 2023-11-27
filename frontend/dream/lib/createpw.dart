import 'package:flutter/material.dart';

class CreatePw extends StatefulWidget {
  final String email;
  final String birth;
  final String name;

  const CreatePw(
      {required this.email,
      required this.name,
      required this.birth,
      super.key});

  // TextEditingController emailcontroller = TextEditingController(text: email);
  @override
  State<CreatePw> createState() => _CreatePwState();
}

class _CreatePwState extends State<CreatePw> {
  bool _isVisible = false;
  bool _isVisible_c = false;
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
                      Text('비밀번호를 입력하세요',
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
                            fillColor: Color.fromRGBO(230, 211, 211, 0.267),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(230, 211, 211, 0.267)))
                            ),
                        readOnly: true,
                        autofocus: false,
                        initialValue: widget.email,
                      ),
                      SizedBox(height: 30),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text('비밀번호', style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold
                        )),
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
                        ),
                        SizedBox(height: 30),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text('비밀번호 확인', style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold
                        )),
                      ),
                       TextField(
                          obscureText: !_isVisible_c,
                          decoration: InputDecoration(
                              // border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                  icon: Icon(_isVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: () => setState(() {
                                        _isVisible_c = !_isVisible_c;
                                      }))),
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          child: const Text('다음'),
                          onPressed: () {
                            
                            
                          },


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
