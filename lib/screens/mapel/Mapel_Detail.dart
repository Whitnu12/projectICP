import 'package:cobalagi2/screens/mapel/Mapel_Chat.dart';
import 'package:cobalagi2/screens/mapel/Mapel_Quiz.dart';
import 'package:cobalagi2/screens/mapel/Mapel_Tambah_Tugas.dart';
import 'package:cobalagi2/screens/mapel/Mapel_presensi.dart';
import 'package:cobalagi2/screens/mapel/tambah_mapel.dart';
import 'package:flutter/material.dart';

class MapelDetail extends StatefulWidget {
  @override
  _MapelDetailState createState() => _MapelDetailState();
}

class _MapelDetailState extends State<MapelDetail> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    TambahMapel(),
    TambahTugas(),
    MapelPresensi()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios_new)),
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Column(children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'IPAS - X TKJ 1',
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    Text(
                      'Feriyati',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ]),
            ),
            SizedBox(
              height: 40,
            ),
            Column(
              children: [
                //card 1
                Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MapelDetail()),
                      );
                    },
                    title: Text(
                      'Sekrotus',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                      ),
                    ),
                    subtitle: Text('Tugas 1'),
                    trailing: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),

                //card 2
                Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MapelDetail()),
                      );
                    },
                    title: Text(
                      'Pengembangan Sosial',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                      ),
                    ),
                    subtitle: Text('Quiz 1'),
                    trailing: Container(
                      width: 12,
                      height: 12,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 100,
            )
          ],
        )),
        bottomNavigationBar: BottomAppBar(
          color: Colors.green[400],
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 5,
              ),
              IconButton(
                color: Colors.white,
                icon: Icon(Icons.assignment),
                onPressed: () {
                  // Pindah ke halaman Tugas
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TambahTugas()));
                },
              ),
              IconButton(
                color: Colors.white,
                icon: Icon(Icons.quiz),
                onPressed: () {
                  // Pindah ke halaman Tugas
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => QuizInputPage()));
                },
              ),
              IconButton(
                color: Colors.white,
                icon: Icon(Icons.chat),
                onPressed: () {
                  // Tindakan untuk menu Quiz
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatPage(
                                idMapel: 1,
                              )));
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green[50],
          shape: const CircleBorder(),
          elevation: 10.0,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MapelPresensi()));
          },
          child: Icon(Icons.check_circle_sharp),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startDocked);
  }
}
