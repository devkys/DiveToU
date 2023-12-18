
import 'package:dream/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {

  static final storage = new FlutterSecureStorage();
  // questionmark allow null-able
  late String? userInfo;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();

    });

  }
  _asyncMethod() async {
    userInfo = await storage.read(key : "login");
    print(userInfo);

    if(userInfo == null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dive To You'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 97, 141, 192),
      ),
    );
  }
}

