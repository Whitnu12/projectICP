import 'package:cobalagi2/screens/siswa/kelas_tinggal.dart';
import 'package:flutter/material.dart';

class Class {
  final String kelas;
  final String mataPelajaran;
  final String waktu;

  Class({
    required this.kelas,
    required this.mataPelajaran,
    required this.waktu,
  });
}

class TenagaKelas extends StatelessWidget {
  final List<Class> classes = [
    Class(
        kelas: 'XII C',
        mataPelajaran: 'Matematika Diskrit',
        waktu: '10.50 - 13.20'),
    Class(
        kelas: 'XII B',
        mataPelajaran: 'Bahasa Indonesia',
        waktu: '10.50 - 12.50'),
    Class(
        kelas: 'XII C',
        mataPelajaran: 'Bahasa Inggris',
        waktu: '13.00 - 15.00'),
    Class(kelas: 'XI A', mataPelajaran: 'Fisika', waktu: '15.10 - 17.10'),
    Class(kelas: 'XI A', mataPelajaran: 'Biologi', waktu: '17.20 - 19.20'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => KelasTinggal(
                          kelas: classes[index].kelas,
                          mataPelajaran: classes[index].mataPelajaran,
                          jamPelajaran: 2,
                          jamMulai: TimeOfDay(hour: 10, minute: 50),
                        )),
              );
            },
            child: Card(
              child: ListTile(
                title: Text(
                  classes[index].kelas,
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
                        Text(classes[index].mataPelajaran),
                        SizedBox(height: 4),
                      ],
                    ),
                    Text(
                      classes[index].waktu,
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
