import 'dart:convert';

import 'package:dream/Team.dart';
import 'package:dream/dashboard.dart';
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
  // SelectFandom({super.key});
  late String user_email;

  SelectFandom(this.user_email);

  @override
  State<SelectFandom> createState() => _SelectFandomState();
}

class _SelectFandomState extends State<SelectFandom> {
  late Future<List<Team>> futureTeam;
  late String user_email;

  @override
  void initState() {
    super.initState();
    futureTeam = fetchTeam();
  }

  // search field controller
  final fieldText = TextEditingController();

  void clearText() {
    fieldText.clear();
  }

  Future choose_artists(String value) async {
    final Uri uri = Uri.parse('http://localhost:3000/artists/choose');

    try {
      var res = await http.post(uri,
        headers: {'Content-type': 'application/json; charset=UTF-8'},
        body: jsonEncode({'user_email': user_email, 'f_artist': value}));
        print(res.body.toString());
        if(res.body.toString() == 'false') {
          // Navigator.push(context, MaterialPageRoute(builder: (context) => Board()));
        }
    }
    catch(e) {
      print(e);
    }

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
    user_email = widget.user_email;
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
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                              title:
                                                  Text(list_team[i].team_name),
                                              content: Text('당신의 아티스트는 ' +
                                                  list_team[i].team_name +
                                                  ' 확실하신가요?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, 'Cancel'),
                                                  child: const Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () => {
                                                    choose_artists(
                                                        list_team[i].team_name)
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            ));
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
