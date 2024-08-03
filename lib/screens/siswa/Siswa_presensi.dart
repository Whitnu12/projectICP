import 'package:flutter/material.dart';

class SiswaPresensi extends StatefulWidget {
  const SiswaPresensi({super.key});

  @override
  State<SiswaPresensi> createState() => _SiswaPresensiState();
}

class _SiswaPresensiState extends State<SiswaPresensi> {
  final TextEditingController _inputPresensiController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30.0),
          SizedBox(
            height: 50,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new),
            ),
          ),
          SizedBox(
            height: 145,
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: Icon(
                    Icons.edit_square,
                    size: 80,
                    color: Colors.green[800],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                    'Masukkan Kode Presensi dari mata Pelajaran yang anda ikuti'),
                TextField(
                  controller: _inputPresensiController,
                  decoration: InputDecoration(),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
