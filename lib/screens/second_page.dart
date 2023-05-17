import 'package:flutter/material.dart';
import 'package:cobalagi2/screens/home_page.dart';
import 'package:cobalagi2/screens/report_page.dart';
import 'package:cobalagi2/screens/teach_page.dart';
import 'package:cobalagi2/model/guruProfile.dart';
import 'login_Page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomePage(),
    ReportPage(),
    TeachPage(),
  ];

  Guru? guruProfile;

  @override
  void initState() {
    super.initState();
    fetchUserProfileFromApi();
  }

  Future<void> fetchUserProfileFromApi() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
      try {
        final profile = await fetchUserProfile(token);
        setState(() {
          guruProfile = profile;
        });
      } catch (e) {
        print('Failed to fetch user profile: $e');
      }
    }
  }

  Future<Guru> fetchUserProfile(String token) async {
    final response = await http.get(
      Uri.parse(
          'http://192.168.100.6/laravel-icp2/public/api/auth/profile'), // Ganti dengan URL profil pengguna di API Laravel Anda
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Guru.fromJson(data);
    } else {
      throw Exception('Failed to fetch user profile');
    }
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              guruProfile?.nama ?? 'Nama Pengguna',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Nomor: ${guruProfile?.npp ?? ''} | Role: ${guruProfile?.jabatan ?? ''}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                logout();
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'logout',
                child: Text('Log Out'),
              ),
            ],
          ),
          CircleAvatar(
            radius: 15,
            backgroundImage: NetworkImage(guruProfile?.fotoProfil ??
                'assets/images/default_profile_picture.png'),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 216, 243, 220),
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            label: 'Laporan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Mengajar',
          ),
        ],
      ),
    );
  }

  void logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    await localStorage.remove('user');
    await localStorage.remove('token');

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Login()),
      (route) => false,
    );
  }
}
