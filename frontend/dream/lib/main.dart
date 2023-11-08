import 'package:flutter/material.dart';
import 'login.dart';


void main() => runApp(const Dive());


class Dive extends StatelessWidget {
  const Dive({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Login(),
      debugShowCheckedModeBanner: false,
    );
  }
}
