

import 'package:dream/createpw.dart';
import 'package:dream/selectFandom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'login.dart';



void main() => runApp(const Dive());


class Dive extends StatelessWidget {
  const Dive({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate
      ], supportedLocales: [
        const Locale('ko', 'KO'),
        const Locale('en', 'US'),
      ],
      home: SelectFandom(),
      debugShowCheckedModeBanner: false,
    );
  }
}