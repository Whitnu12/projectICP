// import 'package:cobalagi2/login_Page%20copy.dart';
// import 'package:flutter/material.dart';
// import 'widgetTree.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cobalagi2/second_page.dart';
// import 'package:cobalagi2/login_Page.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'SMKN 1 Kota Bima',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: LoginPage2(),
//       routes: {
//         '/second': (context) => SecondPage(),
//         '/login': (context) => LoginPage(),
//         '/login_copy': (context) => LoginPage2()
//         // 'login2': (context) => loginScreen(),
//       },
//     );
//   }
// }

import 'package:cobalagi2/screens/login_Page.dart';
import 'package:flutter/material.dart';
import 'screens/second_page.dart';
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
      // darkTheme: ThemeData(
      //     brightness: Brightness.dark, accentColor: Colors.blueAccent),
      // themeMode: ThemeMode.dark,
    );
  }
}

class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != null) {
      if (mounted) {
        setState(() {
          isAuth = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (isAuth) {
      child = SecondPage();
    } else {
      child = Login();
    }

    return Scaffold(
      body: child,
    );
  }
}
