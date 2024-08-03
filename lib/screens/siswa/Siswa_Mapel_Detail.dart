// import 'package:cobalagi2/screens/laporan/lprn_kegiatan.dart';
// import 'package:cobalagi2/screens/laporan/lprn_pendidikan.dart';
// import 'package:cobalagi2/screens/laporan/lprn_penugasan.dart';
import 'package:cobalagi2/screens/mapel/Mapel_Chat.dart';
import 'package:cobalagi2/screens/siswa/Siswa_List_Kuis.dart';
import 'package:cobalagi2/screens/siswa/Siswa_List_tugas.dart';
import 'package:flutter/material.dart';

class MapelDetailSiswa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              width: 50,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_new),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'IPAS - X TKJ 1',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Feriyati, S.Pd',
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildCard(
                          icon: Icons.task,
                          text: 'Tugas',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SiswaListTugas(),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        buildCard(
                          icon: Icons.chat,
                          text: 'Chat',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatPage(
                                  idMapel: 1,
                                ),
                              ),
                            );
                            // Ganti dengan navigasi ke halaman Chat yang sesuai
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildCard(
                          icon: Icons.quiz,
                          text: 'Quiz',
                          onPressed: () {
                            // Ganti dengan navigasi ke halaman Quiz yang sesuai
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ListKuisSiswa(),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        buildCard(
                          icon: Icons.checklist_outlined,
                          text: 'Presensi',
                          onPressed: () {
                            // Ganti dengan navigasi ke halaman Presensi yang sesuai
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return Card(
      color: Colors.green,
      child: Column(
        children: [
          SizedBox(
            height: 150,
            width: 150,
            child: IconButton(
              icon: Icon(
                icon,
                color: Colors.white,
                size: 100,
              ),
              onPressed: onPressed,
            ),
          ),
          Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

void main() {
  runApp(MapelDetailSiswa());
}
