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

  Guru? userProfile;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _fetchUserProfile().then((profile) {
      if (profile != null) {
        setState(() {
          userProfile = profile;
        });
      }
    });
  }

  void _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? userDataJson = localStorage.getString('user');
    String? guruDataJson = localStorage.getString('guru');

    if (userDataJson != null && guruDataJson != null) {
      var userData = jsonDecode(userDataJson);
      var guruData = jsonDecode(guruDataJson);

      print('User Data: $userData');
      print('Guru Data: $guruData');

      setState(() {
        userProfile = Guru(
          userId: userData['data']['user']['id'],
          nama: userData['data']['user']['name'],
          npp: guruData['NPP'],
          email: userData['data']['user']['email'],
          password: guruData['password'],
          jabatan: guruData['jabatan'],
          fotoProfil: guruData['foto_profil'],
          createdAt: DateTime.parse(userData['data']['user']['created_at']),
          updatedAt: DateTime.parse(userData['data']['user']['updated_at']),
        );
      });
    }
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<Guru?> _fetchUserProfile() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? token = localStorage.getString('token');
    if (token != null) {
      try {
        final response = await http.get(
          Uri.parse(
              'http://192.168.100.6/laravel-icp2/public/api/auth/profile'),
          headers: {
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          if (data != null &&
              data['message'] == 'success' &&
              data['data'] != null) {
            return Guru.fromJson(data['data']['guru']);
          }
        }
      } catch (e) {
        print('Error fetching user profile: $e');
      }
    }
    return null;
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
              style: TextStyle(color: Colors.black, fontSize: 22),
            ),
            SizedBox(height: 5),
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
            radius: 20,
            backgroundImage: NetworkImage(
              userProfile?.fotoProfil ??
                  'https://berita.99.co/wp-content/uploads/2022/06/memakai-topi.jpg',
            ),
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

    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Login()),
      (route) => false,
    );
  }
}
