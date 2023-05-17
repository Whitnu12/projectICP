// import 'package:flutter/material.dart';
// import 'auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class SecondPage extends StatefulWidget {
//   @override
//   _SecondPage createState() => _SecondPage();
// }

// class _SecondPage extends State<SecondPage> {
//   int _currentIndex = 0;
//   final List<Widget> _children = [
//     FirstPage(),
//     DuaPage(),
//     ThirdPage(),
//   ];

//   void onTabTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My App'),
//       ),
//       body: _children[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         onTap: onTabTapped,
//         currentIndex: _currentIndex,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Beranda Tenaga',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.report),
//             label: 'Laporan',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.three_p_outlined),
//             label: 'Isi Kelas',
//           ),
//         ],
//       ),
//     );
//   }
// }

// class FirstPage extends StatelessWidget {
//   FirstPage({Key? key}) : super(key: key);

//   final User? user = Auth().currentUser;

//   Future<void> signOut() async {
//     await Auth().signOut();
//   }

//   Widget title() {
//     return const Text('Firebase Auth');
//   }

//   Widget _userUid() {
//     return Text(user?.email ?? 'User ID');
//   }

//   Widget _signOutButton() {
//     return ElevatedButton(
//       onPressed: signOut,
//       child: const Text('Sign Out'),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             _userUid(),
//             _signOutButton(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class DuaPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Center(
//         child: Text('Report'),
//       ),
//     );
//   }
// }

// class ThirdPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Center(
//         child: Text('Teach'),
//       ),
//     );
//   }
// }
