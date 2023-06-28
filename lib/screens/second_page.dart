import 'package:flutter/material.dart';
import 'package:cobalagi2/screens/home_page.dart';
import 'package:cobalagi2/screens/report_page.dart';
import 'package:cobalagi2/screens/teach_page.dart';
import 'package:cobalagi2/model/guruProfile.dart';
import '../network/api.dart';
import 'login_Page.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeScreen(),
    ReportPage(),
    TeachPage(),
  ];

  Guru? userProfile;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Network network = Network();

  void _loadUserData() async {
    try {
      Guru guruProfile = await fetchGuruProfile();

      SharedPreferences localStorage = await SharedPreferences.getInstance();
      String? userDataJson = localStorage.getString('user');
      localStorage.setInt('idGuru', guruProfile.idGuru);

      if (userDataJson != null) {
        var userData = jsonDecode(userDataJson);

        setState(() {
          userProfile = Guru(
            userId: guruProfile.userId,
            idGuru: guruProfile.idGuru,
            nama: guruProfile.nama,
            npp: guruProfile.npp,
            email: guruProfile.email,
            password: guruProfile.password,
            jabatan: guruProfile.jabatan,
          );
        });
      }
    } catch (e) {
      print('Failed to load user data: $e');
    }
  }

  Future<Guru> fetchGuruProfile() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? token = localStorage.getString('token');

    if (token == null) {
      throw Exception('Token not found');
    }

    var headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await network.getData('/auth/profile');

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var guruData = jsonResponse['data']['guru'];

      return Guru(
        userId: guruData['user_id'] as int,
        idGuru: guruData['id_guru'] as int,
        nama: guruData['nama'],
        npp: guruData['npp'],
        email: guruData['email'],
        password: guruData['password'],
        jabatan: guruData['jabatan'],
        createdAt: DateTime.parse(guruData['created_at']),
        updatedAt: DateTime.parse(guruData['updated_at']),
      );
    } else {
      throw Exception('Failed to load guru profile');
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
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Text(
                userProfile?.nama ?? 'Nama Pengguna',
                style: TextStyle(color: Colors.black, fontSize: 22),
              ),
              SizedBox(height: 5),
              Text(
                '${userProfile?.npp ?? ''} | ${userProfile?.jabatan ?? ''}',
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
            SizedBox(
              width: 20,
              child: const DecoratedBox(
                  decoration: BoxDecoration(color: Colors.white)),
            ),
          ],
        ),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 216, 243, 220),
        onTap: onTabTapped,
        unselectedItemColor: Colors.green[500],
        fixedColor: Colors.green[900],
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
    localStorage.clear(); // Menghapus semua nilai yang ada di SharedPreferences

    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Login()),
      (route) => false,
    );
  }
}
