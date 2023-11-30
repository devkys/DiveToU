import 'package:flutter/material.dart';

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
  Uri singerSearch_uri = Uri.parse("https://localhost:3000/search/singer");


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
                    print('enter pressed!!');
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
