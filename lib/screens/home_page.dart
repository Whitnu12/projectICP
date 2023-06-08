import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cobalagi2/network/api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/guruProfile.dart';
import '../model/jadwalMengajar.dart';

int totalJamDiajar = 50;
int targetJam = 110;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class Subject {
  final String subjectName;
  final int totalJamDiajar;
  final int targetJam;

  Subject({
    required this.subjectName,
    required this.totalJamDiajar,
    required this.targetJam,
  });
}

class Class {
  final String mataPelajaran;
  final String kelas;
  final String waktu;
  final String status;

  Class({
    required this.mataPelajaran,
    required this.kelas,
    required this.waktu,
    required this.status,
  });
}

final List<Subject> subjects = [
  Subject(subjectName: 'Teknik Jaringan', totalJamDiajar: 45, targetJam: 60),
  Subject(subjectName: 'Pemrograman Dasar', totalJamDiajar: 50, targetJam: 60),
  Subject(subjectName: 'Sistem Operasi', totalJamDiajar: 55, targetJam: 60),
];

List<Class> classList = [
  Class(
    mataPelajaran: 'Matematika Diskrit',
    kelas: 'XII C',
    waktu: '08.40 - 10.40',
    status: 'akan datang',
  ),
  Class(
    mataPelajaran: 'Jaringan Keamanan Komputer',
    kelas: 'XII B',
    waktu: '10.50 - 12.50',
    status: 'mengajar',
  ),
  Class(
    mataPelajaran: 'Pancasila',
    kelas: 'XII A',
    waktu: '13.00 - 15.00',
    status: 'mengajar',
  ),
  Class(
    mataPelajaran: 'Cloud Computing',
    kelas: 'XII A',
    waktu: '15.10 - 17.10',
    status: 'ditinggalkan',
  ),
  Class(
    mataPelajaran: 'Jaringan Komputer Praktik',
    kelas: 'XII B',
    waktu: '17.20 - 19.20',
    status: 'mengajar',
  ),
];

class _HomeScreenState extends State<HomeScreen> {
  List<JadwalMengajar> jadwalList = []; // Daftar jadwal mengajar
  Network network = Network();
  int idGuru = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(top: 20, start: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kelas hari ini',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 160,
              child: ListView.builder(
                itemCount: classList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  Class currentClass = classList[index];
                  bool isMengajar = currentClass.status == 'mengajar';
                  bool isDitinggalkan = currentClass.status == 'ditinggalkan';
                  bool isAkanDatang = currentClass.status == 'akan datang';

                  return Container(
                    width: 340,
                    child: Card(
                      color:
                          isDitinggalkan ? Colors.red[100] : Colors.green[100],
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 30),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        currentClass.mataPelajaran,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 30),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      currentClass.kelas,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 30),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    currentClass.waktu,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    currentClass.status,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Capain jam belajar',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: subjects
                  .length, // Ganti dengan jumlah data jadwal pelajaran esok hari
              itemBuilder: (BuildContext context, int index) {
                Subject currentSubject = subjects[index];
                double progress =
                    currentSubject.totalJamDiajar / currentSubject.targetJam;

                return Card(
                  child: Container(
                    padding: EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentSubject.subjectName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        LinearProgressIndicator(
                          color: Colors.green,
                          backgroundColor: Colors.greenAccent[100],
                          value: progress,
                          minHeight: 10,
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${currentSubject.totalJamDiajar} / ${currentSubject.targetJam}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
