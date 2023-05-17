// import 'package:cobalagi2/login_Page.dart';
// import 'package:cobalagi2/second_page.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:cobalagi2/auth.dart';

// class WidgetTree extends StatefulWidget {
//   const WidgetTree({Key? key}) : super(key: key);
//   @override
//   State<WidgetTree> createState() => _WidgetTreeState();
// }

// class _WidgetTreeState extends State<WidgetTree> {
//   bool _isLoading = true;
//   bool _isLoggedIn = false;

//   @override
//   void initState() {
//     super.initState();
//     checkLoggedInStatus();
//   }

//   Future<void> checkLoggedInStatus() async {
//     try {
//       final token = await LoginPage()._auth.signinWithEmailAndPassword(
//         email: 'your_email',
//         password: 'your_password',
//       );

//       final response = await http.get(
//         Uri.parse('http://192.168.100.6/laravel-icp2/public/api/auth/profile'),
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         final responseData = json.decode(response.body);
//         final receivedToken = responseData['token'];

//         setState(() {
//           _isLoggedIn = receivedToken != null;
//         });
//       }
//     } catch (e) {
//       print('An error occurred: $e');
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading) {
//       return CircularProgressIndicator();
//     } else {
//       return _isLoggedIn ? SecondPage() : LoginPage();
//     }
//   }
// }
