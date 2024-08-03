import 'package:cobalagi2/screens/login_Page.dart';
import 'package:cobalagi2/screens/guru/GuruLayout.dart';
import 'package:flutter/material.dart';
import 'screens/siswa/Siswa_Layout.dart';
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
        splash: Image.asset('assets/images/E-Management (6).png'),
        splashIconSize: 530,
        duration: 3000,
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.white,
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
  String? nis_nip; // Hapus baris ini

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    nis_nip =
        localStorage.getString('nip_nis'); // Hapus var dan gunakan var di sini

    if (token != null) {
      if (mounted) {
        setState(() {
          isAuth = true;
        });
      }
    }
  }

  int panjangNIS = 5;
  int panjangNIP = 18;

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (isAuth) {
      if (nis_nip?.length == panjangNIS) {
        child = TenagaSpace();
      } else {
        child = GuruLayout();
      }
    } else {
      child = Login();
    }

    return Scaffold(
      body: child,
    );
  }
}
