import 'package:cobalagi2/model/guruProfile.dart';
import 'package:cobalagi2/screens/siswa/Siswa_List_Mapel.dart';
import 'package:cobalagi2/screens/siswa/Siswa_presensi.dart';
import 'package:cobalagi2/util/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:cobalagi2/screens/login_Page.dart';
import 'package:cobalagi2/screens/siswa/Siswa_Home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TenagaSpace extends StatefulWidget {
  @override
  _TenagaSpaceState createState() => _TenagaSpaceState();
}

class _TenagaSpaceState extends State<TenagaSpace> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeSiswa(),
    SiswaMapelList(),
  ];

  User? userProfile;

  @override
  void initState() {
    super.initState();
  }

  String idUser = AuthProvider.instance.idUser;
  String namaGuru = AuthProvider.instance.name;
  String nisNip = AuthProvider.instance.nisNip;

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
                namaGuru,
                style: TextStyle(color: Colors.black, fontSize: 22),
              ),
              SizedBox(height: 5),
              Text(
                '${nisNip} | Siswa',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            PopupMenuButton(
              child: CircleAvatar(
                radius: 28,
                backgroundImage: AssetImage("assets/images/user_profile.jpg"),
              ),
              onSelected: (value) {
                if (value == "profile") {
                  // add desired output
                } else if (value == "settings") {
                  // add desired output
                } else if (value == "logout") {
                  logout();
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                PopupMenuItem(
                  value: "profile",
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.book),
                      ),
                      const Text(
                        'Profile',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: "settings",
                  child: Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.settings)),
                      const Text(
                        'Settings',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: "logout",
                  child: Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.logout)),
                      const Text(
                        'Logout',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ],
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
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.green[500],
        fixedColor: Colors.green[900],
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            label: 'coba',
            icon: const ImageIcon(
              AssetImage(
                "assets/images/house-blank.png",
              ),
            ),
          ),
          BottomNavigationBarItem(
              icon: const ImageIcon(
                AssetImage(
                  "assets/images/book-alt.png",
                ),
              ),
              label: ''),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[50],
        shape: const CircleBorder(),
        elevation: 10.0,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SiswaPresensi()),
          );
        },
        child: Icon(Icons.qr_code_scanner_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.clear(); // Menghapus semua nilai yang ada di SharedPreferences

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Login()),
      (route) => false,
    );
  }
}
