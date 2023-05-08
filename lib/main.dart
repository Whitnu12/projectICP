import 'package:cobalagi2/login_2.dart';
import 'package:flutter/material.dart';
import 'widgetTree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cobalagi2/second_page.dart';
import 'package:cobalagi2/login_Page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SMKN 1 Kota Bima',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WidgetTree(),
      routes: {
        '/second': (context) => SecondPage(),
        '/login': (context) => LoginPage(),
        'login2': (context) => loginScreen(),
      },
    );
  }
}
