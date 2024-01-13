import 'package:dream/BoardContents.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  final BoardContents contents;

  Detail({super.key, required this.contents});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    // final detail = ModalRoute.of(context)!.settings.arguments as BoardContents;
    return Scaffold(
      appBar: AppBar(
        title: Text('게시하기'),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Row(children: [
              CircleAvatar(backgroundColor: Colors.amber),
              Text(widget.contents.writer)
            ]),
            Column()
          ],
        ),
      )),
    );
  }
}
