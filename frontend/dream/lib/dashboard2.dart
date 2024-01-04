import 'dart:convert';
import 'dart:io';
import 'package:dream/User.dart';
import 'package:dream/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class Board2 extends StatefulWidget {
  final User user;

  Board2({required this.user});

  @override
  State<Board2> createState() => _BoardState();
}

class _BoardState extends State<Board2> {
  late User s_user;
  late File img;

  final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    s_user = widget.user;
  }

  Future f_color() async {
    // Uri uri = 

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          key: _key,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.0),
            child: AppBar(
              title: Text('Dive to you'),
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
              bottom: TabBar(tabs: <Widget> [
                Tab(text: "타임라인",iconMargin: EdgeInsets.all(10.0)),
                Tab(text: "지도",iconMargin: EdgeInsets.all(10.0)),
      
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
                      GFDrawerHeaderPictures(
                        centerAlign: true,
                        closeButton:
                            Visibility(child: this.widget, visible: false),
                        currentAccountPicture: GFAvatar(
                          backgroundImage: AssetImage(s_user.img_url),
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
                          Text('222', style: TextStyle(fontWeight: FontWeight.bold),),
                          Text('팔로워'),
                          Text('33', style: TextStyle(fontWeight: FontWeight.bold),),
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
        ),
      ),
    );
  }
}
