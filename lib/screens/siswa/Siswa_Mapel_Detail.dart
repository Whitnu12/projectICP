// import 'package:cobalagi2/screens/laporan/lprn_kegiatan.dart';
// import 'package:cobalagi2/screens/laporan/lprn_pendidikan.dart';
// import 'package:cobalagi2/screens/laporan/lprn_penugasan.dart';
import 'package:flutter/material.dart';

class MapelDetailSiswa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.all(16),
      crossAxisCount: 2,
      children: [
        buildCard(
          icon: Icons.task,
          name: 'tugas',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MapelDetailSiswa()),
            );
          },
        ),
        buildCard(
          icon: Icons.quiz,
          name: 'Quiz',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MapelDetailSiswa()),
            );
          },
        ),
        buildCard(
          icon: Icons.person,
          name: 'Presensi',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MapelDetailSiswa()),
            );
          },
        ),
        buildCard(
          icon: Icons.chat,
          name: 'Forum Chat',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MapelDetailSiswa()),
            );
          },
        ),
      ],
    );
  }

  Widget buildCard({
    required IconData icon,
    required String name,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 60,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            Text(
              name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildCard({
  required IconData icon,
  required String name,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 60,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16),
          Text(
            name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

// Contoh halaman laporan pendidikan

