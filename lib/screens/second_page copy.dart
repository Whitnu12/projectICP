// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/guruProfile.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPage createState() => _SecondPage();
}

class _SecondPage extends State<SecondPage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    FirstPage(),
    DuaPage(),
    ThirdPage(),
  ];

  Guru? userProfile;

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
          userProfile = profile;
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
              userProfile?.nama ?? 'Nama Pengguna',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Nomor: ${userProfile?.npp ?? ''} | Role: ${userProfile?.jabatan ?? ''}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          CircleAvatar(
            radius: 15,
            backgroundImage: NetworkImage(
                userProfile?.fotoProfil ?? 'assets/images/foto_profil.png'),
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
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Home'),
      ),
    );
  }
}

class DuaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Report'),
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: ElevatedButton(
        onPressed: () {
          // Navigator.push(
          // context, MaterialPageRoute(builder: (context) => ()));
        },
        child: Text('Coba'),
      )),
    );
  }
}
