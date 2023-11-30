import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SelectFandom extends StatefulWidget {
  const SelectFandom({super.key});

  @override
  State<SelectFandom> createState() => _SelectFandomState();
}

class _SelectFandomState extends State<SelectFandom> {
  // search field controller
  final fieldText = TextEditingController();

  void clearText() {
    fieldText.clear();
  }
 
  // Uri singerSearch_uri = Uri.http("http://localhost:3000/search/singer");

  Future singer(String singer) async {

    // 가수 이름 쿼리 파라미터
    // final queryParams = {
    //   'team' : singer
    // };

    final singerSearch_uri = Uri.http('localhost:3000', '/search/artists', {'team' : singer});
    // http://localhost:3000/search/artists?team=${singer.text}
    try {
      var res = await http.get(singerSearch_uri, 
      headers: {'Content-Type' : 'application/json; charset=UTF-8'},
      );

    } catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                height: 700,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  controller: fieldText,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      hintText: 'enter',
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: IconButton(
                          icon: Icon(Icons.cancel_outlined),
                          onPressed: () {
                            clearText();
                          })),
                  onFieldSubmitted: (value) {
                    singer(value);
                    print(value);
                  },
                  textInputAction: TextInputAction.search,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
