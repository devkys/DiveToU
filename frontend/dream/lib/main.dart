

import 'dart:convert';

import 'package:dream/User.dart';
import 'package:dream/UserProvider.dart';
import 'package:dream/dashboard.dart';
import 'package:dream/dashboard2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'login.dart';



void main() => runApp(Dive());
// void main() => runApp(
//   MultiProvider(
//     providers: [
//       Provider(create:
//       (context) => UserProvider())
//     ],
//     child: const Dive(),
//   )
// );


class Dive extends StatelessWidget {
  Dive({super.key});
 
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate
      ], supportedLocales: [
        const Locale('ko', 'KO'),
        const Locale('en', 'US'),
      ],
      home: FutureBuilder(
        future: checkUserLogin(), // 사용자 정보 확인 비동기 함수
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
         if (snapshot.data != null) {
          print(snapshot.data!.email);
        // 사용자가 로그인한 경우, 사용자 정보를 Board 위젯으로 전달합니다.
        return Board2(user: snapshot.data!); // 'snapshot.data'가 사용자 정보라고 가정합니다.
      } else {
        // 사용자가 로그인하지 않은 경우, Login 위젯을 표시합니다.
        return Login();
      }
          } else {
            // 로딩 중이나 에러 상태일 때 로딩 표시
            return CircularProgressIndicator();
          }
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  Future<User?> checkUserLogin() async {
    final storage = FlutterSecureStorage();
    String? userInfo = await storage.read(key: "login");
    User s_user;
    if(userInfo != null) {
      Map<String, dynamic> jsonData = jsonDecode(userInfo);
      s_user = User (email: jsonData['email'], name: jsonData['name'], img_url: jsonData['img_url'],secret: jsonData['secret']);
      return s_user;
    } else {
      return null;
    }
  }
}