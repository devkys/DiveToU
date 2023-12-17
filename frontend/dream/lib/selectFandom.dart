import 'dart:convert';
import 'dart:math';

import 'package:dream/Team.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Team>> fetchTeam() async {
  final response =
      await http.get(Uri.parse('http://localhost:3000/artists/search/all'));

  if (response.statusCode == 200) {
    // final parsed = (jsonDecode(response.body) as List).cast<Map<String, dynamic>>();
    // return parsed.map<Team>((json) => Team.fromJson(json)).toList();

    final parsed =
        (jsonDecode(response.body) as List).cast<Map<String, dynamic>>();
    // print(parsed.runtimeType);
    print(parsed.map<Team>((json) => Team.fromJson(json)).toList().runtimeType);
    // print(parsed[1]);

    return parsed.map<Team>((json) => Team.fromJson(json)).toList();
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
  late Future<List<Team>> futureTeam;

  @override
  void initState() {
    super.initState();
    futureTeam = fetchTeam();
  }

  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 2), vsync: this)
        ..repeat(reverse: true);

  late final Animation<AlignmentGeometry> _animation = Tween<AlignmentGeometry>(
    begin: Alignment(-1, -1),
    end: Alignment.center,
  ).animate(CurvedAnimation(
      parent: _controller, curve: Curves.easeInOutCubicEmphasized));

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
                child: FutureBuilder<List<Team>>(
                  future: futureTeam,
                  builder: (context, snapshot) {
                    List<Team> list_team = snapshot.data ?? [];
                    if (snapshot.hasData) {
                      return GridView.count(
                        crossAxisCount: 3,
                        children: [
                          for (var i = 0; i < list_team.length; i++) ...[
                            Column(
                              children: [
                                InkWell(
                                  child: CircleAvatar(
                                    backgroundImage:
                                        AssetImage(list_team[i].r_image),
                                    radius: 45,
                                  ),
                                  onTap: () {
                                    // 선택한 그룹명 출력
                                    print(list_team[i].team_name);
                                  },
                                ),
                                Text(
                                  snapshot.data![i].team_name,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ]
                        ], // end of for
                      );
                    } else if (snapshot.hasError) {
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