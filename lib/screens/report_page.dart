import 'package:cobalagi2/screens/laporan/lprn_kegiatan.dart';
import 'package:cobalagi2/screens/laporan/lprn_pendidikan.dart';
import 'package:cobalagi2/screens/laporan/lprn_penugasan.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.all(16),
      crossAxisCount: 2,
      children: [
        buildCard(
          icon: Icons.school,
          name: 'Laporan Pendidikan',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LaporanPendidikan()),
            );
          },
        ),
        buildCard(
          icon: Icons.run_circle_outlined,
          name: 'Laporan Kegiatan',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LaporanKegiatan()),
            );
          },
        ),
        buildCard(
          icon: Icons.article,
          name: 'Laporan Penugasan',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LaporanPenugasan()),
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

