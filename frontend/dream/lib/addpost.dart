import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('포스트 작성하기')),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
                hintText: '게시물을 작성하세요...',
                contentPadding: EdgeInsets.symmetric(vertical: 100.0)),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () => setState(() {
                        _isVisible = !_isVisible;
                      }),
                  icon: Icon(
                      size: 40.0,
                      _isVisible
                          ? Icons.favorite
                          : Icons.favorite_border_outlined))
            ],
          )
        ],
      ),
    );
  }
}
