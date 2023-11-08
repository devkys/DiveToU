
import 'package:flutter/material.dart';

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dive To You'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 97, 141, 192),
      ),


    );
  }
}

