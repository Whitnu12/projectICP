import 'package:cobalagi2/screens/tenaga_kependidikan/kelas_tinggal.dart';
import 'package:flutter/material.dart';

class HomeTenaga extends StatefulWidget {
  const HomeTenaga({super.key});

  @override
  State<HomeTenaga> createState() => _HomeTenagaState();
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
  final TimeOfDay jamMulai;
  final int jamPelajaran;
  final String status;

  Class({
    required this.mataPelajaran,
    required this.kelas,
    required this.jamMulai,
    required this.jamPelajaran,
    required this.status,
  });

  TimeOfDay get jamSelesai {
    int totalMenit = jamMulai.hour * 60 + jamMulai.minute + 45;
    int jam = totalMenit ~/ 60;
    int menit = totalMenit % 60;
    return TimeOfDay(hour: jam, minute: menit);
  }
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
    jamMulai: TimeOfDay(hour: 10, minute: 50),
    jamPelajaran: 2,
    status: 'ditinggalkan',
  ),
  Class(
    mataPelajaran: 'Jaringan Keamanan Komputer',
    kelas: 'XII B',
    jamMulai: TimeOfDay(hour: 12, minute: 30),
    jamPelajaran: 3,
    status: 'ditinggalkan',
  ),
  Class(
    mataPelajaran: 'Jaringan Keamanan Komputer',
    kelas: 'XII D',
    jamMulai: TimeOfDay(hour: 7, minute: 30),
    jamPelajaran: 4,
    status: 'ditinggalkan',
  ),
  Class(
    mataPelajaran: 'Jaringan Keamanan Komputer',
    kelas: 'XII B',
    jamPelajaran: 3,
    jamMulai: TimeOfDay(hour: 14, minute: 30),
    status: 'ditinggalkan',
  ),
];

class _HomeTenagaState extends State<HomeTenaga> {
  bool _isClassLeft = true;
  String _leaveReason = 'Ada Rapat Pusat di Jakarta';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsetsDirectional.only(top: 20, start: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kelas kosong hari ini',
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
                    bool isDitinggalkan = currentClass.status == 'ditinggalkan';

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => KelasTinggal(
                                kelas: currentClass.kelas,
                                mataPelajaran: currentClass.mataPelajaran,
                                jamMulai: currentClass.jamMulai,
                                jamPelajaran: currentClass.jamPelajaran),
                          ),
                        );
                      },
                      child: Container(
                        width: 340,
                        child: Card(
                          color: isDitinggalkan
                              ? Colors.red[100]
                              : Colors.green[100],
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        '${currentClass.jamMulai.hour.toString().padLeft(2, '0')}:${currentClass.jamMulai.minute.toString().padLeft(2, '0')} - ${currentClass.jamSelesai.hour.toString().padLeft(2, '0')}:${currentClass.jamSelesai.minute.toString().padLeft(2, '0')}',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        ' ${currentClass.status}',
                                        style: TextStyle(
                                          fontSize: 18,
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
                itemCount: subjects.length,
                itemBuilder: (BuildContext context, int index) {
                  Class currentClass = classList[index];

                  return Card(
                    child: SizedBox(
                      height: 350,
                      child: Card(
                        color: _isClassLeft
                            ? Colors.green[100]
                            : Colors.green[100],
                        elevation: 4,
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ' ${currentClass.kelas} ',
                                        style: TextStyle(
                                            fontSize: 34,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        ' ${currentClass.mataPelajaran}',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${currentClass.jamMulai.hour.toString().padLeft(2, '0')}:${currentClass.jamMulai.minute.toString().padLeft(2, '0')}',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                ],
                              ),
                              SizedBox(height: 80),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: _isClassLeft
                                    ? [
                                        Text(
                                          'Pesan Untuk Anda',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          _leaveReason,
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ]
                                    : [],
                              ),
                              SizedBox(
                                height: 90,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
