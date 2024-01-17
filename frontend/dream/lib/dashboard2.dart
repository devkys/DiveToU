import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dream/User.dart';
import 'package:dream/UserProvider.dart';
import 'package:dream/addpost.dart';
import 'package:dream/detail.dart';
import 'package:dream/upd_myinfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;
import 'package:dream/BoardContents.dart';

Future<List<BoardContents>> fetchBoard() async {
  final response =
      await http.get(Uri.parse('http://localhost:3000/api/board/get/all'));
  if (response.statusCode == 200) {
    // final parsed = (jsonDecode(response.body) as List).cast<Map<String, dynamic>>();
    final parsed =
        (jsonDecode(response.body) as List).cast<Map<String, dynamic>>();

    print(parsed
        .map<BoardContents>((json) => BoardContents.fromJson(json))
        .toList());
    return parsed
        .map<BoardContents>((json) => BoardContents.fromJson(json))
        .toList();
  } else {
    throw Exception('Failed to load board list');
  }
}

class Board2 extends StatefulWidget {
  final User user;

  Board2({required this.user});

  @override
  State<Board2> createState() => _BoardState();
}

// 지도 api 관련
Future<void> _initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance.initialize(
      clientId: 'dhyxg8ixsv',
      onAuthFailed: (ex) => print("********* 네이버맵 인증오류 : $ex *********"));
}

class _BoardState extends State<Board2> {
  late User s_user;
  late File img;
  late Future<List<BoardContents>> boardlist;

  final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();

  // late NaverMapController _mapController;
  // final Completer<NaverMapController> mapControllerCompleter = Completer();

  @override
  void initState() {
    super.initState();
    // 네이버 지도 관련 api
    // _initialize();
    s_user = widget.user;
    boardlist = fetchBoard();
  }

  Future f_color() async {
    // Uri uri =
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          key: _key,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.0),
            child: AppBar(
              title: Text('Dive to you'),
              notificationPredicate: (ScrollNotification notification) {
                return notification.depth == 1;
              },
              automaticallyImplyLeading: false,
              leading: InkWell(
                child: Container(
                    margin: EdgeInsets.fromLTRB(10.0, 4.0, 0.0, 0.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.0),
                        image: DecorationImage(
                            alignment: Alignment.center,
                            image: AssetImage(s_user.img_url)))),
                onTap: () => _key.currentState!.openDrawer(),
              ),
              bottom: TabBar(tabs: <Widget>[
                Tab(text: "타임라인", iconMargin: EdgeInsets.all(10.0)),
                Tab(text: "지도", iconMargin: EdgeInsets.all(10.0)),
              ]),
            ),
          ),
          drawer: GFDrawer(
              child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: 350,
                child: GFDrawerHeader(
                  closeButton: Visibility(
                    child: this.widget,
                    visible: false,
                  ),
                  decoration: BoxDecoration(color: Colors.amber),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 50.0),
                    child: Column(children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyInfo()));
                        },
                        child: GFDrawerHeaderPictures(
                          centerAlign: true,
                          closeButton:
                              Visibility(child: this.widget, visible: false),
                          currentAccountPicture: GFAvatar(
                            backgroundImage: AssetImage(s_user.img_url),
                          ),
                        ),
                      ),
                      SizedBox(height: 25.0),
                      Text(s_user.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0)),
                      SizedBox(height: 25.0),
                      Text(s_user.email,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18.0)),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('팔로잉'),
                          Text(
                            '222',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('팔로워'),
                          Text(
                            '33',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ]),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.notifications),
                title: Text('알림'),
                onTap: () {},
                // trailing: Icon(Icons.abc_outlined),
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text('좋아요'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.bookmark),
                title: Text('북마크'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.message),
                title: Text('메시지'),
                onTap: () {},
                // trailing: Icon(Icons.abc_outlined),
              ),
            ],
          )),
          body: TabBarView(children: [
            FutureBuilder<List<BoardContents>>(
                future: boardlist,
                builder: (context, snapshot) {
                  List<BoardContents> list = snapshot.data ?? [];
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                              backgroundImage:
                                  AssetImage(list[index].img_url!)),
                          title: Text(list[index].writer),
                          subtitle: Text(list[index].contents),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Detail(contents: list[index])));
                          },
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                }),
            Center(
              child: Text('dd'),
            )
            // Center(
            //     child:
            //       NaverMap(
            //         options: NaverMapViewOptions(),
            //         onMapReady: (controller) => {
            //           _mapController = controller,
            //           print('map loading@@')
            //         },
            //       )

            // )
            // ListView.builder(
            //   itemCount: 1,
            //   itemBuilder: (context, index) {
            //     return ListTile(
            //       tileColor: Colors.red,
            //       title: Text('dd'),

            //     );
            //   },
            // ),
          ]),
          floatingActionButton: FloatingActionButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> AddPost()));
          },
          child: const Icon(Icons.add),
          
          ),
        ),
      ),
    );
  }
}

Widget bb() {
  return Column();
}
