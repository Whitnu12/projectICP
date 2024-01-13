import 'dart:convert';

import 'package:cobalagi2/model/jadwalMengajar.dart';
import 'package:cobalagi2/screens/detail_mapel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/api.dart';

class TeachPage extends StatefulWidget {
  @override
  _TeachPageState createState() => _TeachPageState();
}

JadwalMengajar? classes;

class _TeachPageState extends State<TeachPage> {
  List<JadwalMengajar> classes = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<int> getIdGuruFromSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int idGuru = prefs.getInt('idGuru') ?? 0;
    return idGuru;
  }

  Future<void> fetchData() async {
    int idGuru = await getIdGuruFromSharedPreference();
    idGuru.toString();
    try {
      // Mengirim permintaan HTTP GET ke endpoint /jadwal-mengajar
      final response = await Network().getData('/jadwal-mengajar/$idGuru');

      if (response.statusCode == 200) {
        // Jika permintaan berhasil, parsing data JSON ke dalam daftar classes
        final jsonData = json.decode(response.body);
        final List<dynamic> data = jsonData;
        classes = data.map((item) => JadwalMengajar.fromJson(item)).toList();
        setState(() {});
      } else {
        // Jika permintaan gagal, tampilkan pesan kesalahan
        print('Terjadi kesalahan: ${response.statusCode}');
      }
    } catch (e) {
      // Jika terjadi kesalahan saat melakukan permintaan, tampilkan pesan kesalahan
      print('Terjadi kesalahan: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          final JadwalMengajar jadwal = classes[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailMengajar(
                    kelas: jadwal.namaKelas,
                    mataPelajaran: jadwal.namaMapel,
                    jamBelajar: jadwal.jamBelajar,
                    jamMulai: jadwal.jamMulai,
                    jamSelesai: jadwal.jamSelesai,
                  ),
                ),
              );
            },
            child: Card(
              child: ListTile(
                title: Text(
                  jadwal.namaKelas,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(jadwal.namaMapel),
                        SizedBox(height: 4),
                      ],
                    ),
                    Text(
                      jadwal.jamMulai,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemCount: classes.length,
      ),
    );
  }
}
