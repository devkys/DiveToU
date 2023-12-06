import 'dart:convert';
import 'dart:math';

import 'package:dream/Team.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


Future<List> fetchTeam() async {
  final response =
      await http.get(Uri.parse('http://localhost:3000/artists/search/all'));

  // List<Team> listmodel = <Team>[];
  List listmodel2=[];
  if (response.statusCode == 200) {
    // final parsed = (jsonDecode(response.body) as List).cast<Map<String, dynamic>>();
    // return parsed.map<Team>((json) => Team.fromJson(json)).toList();

    var list = jsonDecode(response.body) as List;
    // print(list.runtimeType);
    // print(list.length);
    final parsed = (jsonDecode(response.body) as List).cast<Map<String, dynamic>>();
    print(parsed.runtimeType);
    // listmodel2.add(parsed.map<Team>((json) => Team.fromJson(json)).toList());
    print(parsed[0]);
    // for (var i = 0; i < list.length; i++) {

     

    //   // listmodel.add(Team.fromJson(list[i] as Map<String, dynamic>));

    // }

  // print(jsonDecode(response.body));
  // print(jsonDecode(response.body)[0]);
  // print(jsonDecode(response.body).runtimeType);
  // print(jsonDecode(response.body)[0].runtimeType);
  return listmodel2;
  // return Team.fromJson(jsonDecode(response.body)[0] as Map<String, dynamic>);

  } else {
    throw Exception('Failed to load Team');
  }
}

class SelectFandom extends StatefulWidget {
  const SelectFandom({super.key});

  @override
  State<SelectFandom> createState() => _SelectFandomState();
}

class _SelectFandomState extends State<SelectFandom>
    with TickerProviderStateMixin {
  late Future<List> futureTeam;

  @override
  void initState() {
    super.initState();
    futureTeam = fetchTeam();
  }

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<AlignmentGeometry> _animation = Tween<AlignmentGeometry>(
    begin: Alignment(-1, -1),
    end: Alignment.center,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.decelerate));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // search field controller
  final fieldText = TextEditingController();

  void clearText() {
    fieldText.clear();
  }

  Future singer(String singer) async {
    final singerSearch_uri =
        Uri.http('localhost:3000', '/artists/search/name', {'team': singer});

    try {
      var res = await http.get(
        singerSearch_uri,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );
    } catch (e) {
      print(e);
    }
  }

  // 전체 아티스트 조회
  Uri artist_all = Uri.parse('http://localhost:3000/artists/search/all');
  Future inquiry() async {
    try {
      var res = await http.get(artist_all,
          headers: {'Content-Type': 'application/json; charset=UTF-8'});
    } catch (e) {
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
                height: 50,
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
              Container(
                height: 650,
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder<List>(
                  future: futureTeam,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return AlignTransition(
                          alignment: _animation,
                          child: Column(
                            children: [
                              // for(num=0;)
                              // CircleAvatar(
                              //   backgroundImage:
                              //       AssetImage(snapshot.data!.r_image),
                              //   radius: 40,
                              // ),
                              // Text(snapshot.data!.team_name)
                            ],
                          ));
                    } else if(snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class MyCustomPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint();
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     // TODO: implement shouldRepaint
//     throw UnimplementedError();
//   }
// }
