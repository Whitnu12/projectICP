import 'package:cobalagi2/screens/login_Page.dart';
import 'package:flutter/material.dart';
import 'screens/second_page.dart';
import 'screens/tenaga_kependidikan/layout_tenaga.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'splash screen',
      home: AnimatedSplashScreen(
        splash: Image.asset('assets/images/Logo-1.png'),
        splashIconSize: 530,
        duration: 3000,
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.green.shade100,
        nextScreen: CheckAuth(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;
  String? role;

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    var userRole = localStorage.getString('jabatan');

    if (token != null && userRole != null) {
      if (mounted) {
        setState(() {
          isAuth = true;
          role = userRole;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (isAuth) {
      if (role == "tenaga_kependidikan") {
        child = TenagaSpace();
      } else {
        child = SecondPage();
      }
    } else {
      child = Login();
    }

    return Scaffold(
      body: child,
    );
  }
}
