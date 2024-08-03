import 'package:cobalagi2/screens/mapel/Mapel_List.dart';
import 'package:cobalagi2/util/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:cobalagi2/screens/guru/GuruHome.dart';
// import 'package:cobalagi2/screens/report_page.dart';
import '../../network/api.dart';
import '../login_Page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuruLayout extends StatefulWidget {
  @override
  _GuruLayoutState createState() => _GuruLayoutState();
}

class _GuruLayoutState extends State<GuruLayout> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    GuruHome(),
    MapelList(),
  ];

  // Guru? userProfile;

  @override
  void initState() {
    super.initState();
    // _loadUserData();
  }

  Network network = Network();

  // void _loadUserData() async {
  //   try {
  //     Guru guruProfile = await fetchGuruProfile();

  //     SharedPreferences localStorage = await SharedPreferences.getInstance();
  //     String? userDataJson = localStorage.getString('user');
  //     localStorage.setInt('idGuru', guruProfile.idGuru);

  //     if (userDataJson != null) {
  //       var userData = jsonDecode(userDataJson);

  //       setState(() {
  //         userProfile = Guru(
  //           userId: guruProfile.userId,
  //           idGuru: guruProfile.idGuru,
  //           nama: guruProfile.nama,
  //           npp: guruProfile.npp,
  //           email: guruProfile.email,
  //           password: guruProfile.password,
  //           jabatan: guruProfile.jabatan,
  //         );
  //       });
  //     }
  //   } catch (e) {
  //     print('Failed to load user data: $e');
  //   }
  // }

  // Future<Guru> fetchGuruProfile() async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   String? token = localStorage.getString('token');

  //   if (token == null) {
  //     throw Exception('Token not found');
  //   }

  //   var headers = {
  //     'Content-type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   };

  //   var response = await network.getData('/auth/profile');

  //   if (response.statusCode == 200) {
  //     var jsonResponse = json.decode(response.body);
  //     var guruData = jsonResponse['data']['guru'];

  //     return Guru(
  //       userId: guruData['user_id'] as int,
  //       idGuru: guruData['id_guru'] as int,
  //       nama: guruData['nama'],
  //       npp: guruData['npp'],
  //       email: guruData['email'],
  //       password: guruData['password'],
  //       jabatan: guruData['jabatan'],
  //       createdAt: DateTime.parse(guruData['created_at']),
  //       updatedAt: DateTime.parse(guruData['updated_at']),
  //     );
  //   } else {
  //     throw Exception('Failed to load guru profile');
  //   }
  // }

  void onTabTapped(int index) {
    print('Current Index: $index');
    setState(() {
      _currentIndex = index;
    });
  }

  String idUser = AuthProvider.instance.idUser;
  String namaGuru = AuthProvider.instance.name;
  String nisNip = AuthProvider.instance.nisNip;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //Top Bar
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 200,
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
                '${nisNip} | ${'Guru'}',
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
    );
  }

  void logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.clear(); // Menghapus semua nilai yang ada di SharedPreferences

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => Login()),
      (route) => false,
    );
  }
}
