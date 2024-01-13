import 'dart:convert';
import 'package:cobalagi2/model/capaian_jam.dart';
import 'package:flutter/material.dart';
// import 'package:cobalagi2/network/api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// import '../model/guruProfile.dart';
import '../model/jadwalMengajar.dart';
import '../network/api.dart';
import 'detail_mapel.dart';
import 'teach_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<JadwalMengajar> jadwalMengajarList = [];
  List<CapaianJam> capaianJamList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getDataJadwalMengajar();
    getDataCapaianBelajar();
  }

  Future<int> getIdGuruFromSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int idGuru = prefs.getInt('idGuru') ?? 0;
    return idGuru;
  }

  void getDataCapaianBelajar() async {
    Network network = Network();
    int idGuru = await getIdGuruFromSharedPreference();
    idGuru.toString();

    try {
      http.Response response = await network.getData('/capaian-jam/$idGuru');

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        isLoading = false;

        List<CapaianJam> capaianJamData = (responseData['data'] as List)
            .map((json) => CapaianJam.fromJson(json))
            .toList();

        setState(() {
          capaianJamList = capaianJamData;
        });
      } else {
        print(
            'Gagal mengambil data capaian belajar. Status: ${response.statusCode}');
      }
    } catch (error) {
      print('Terjadi kesalahan: $error');
    }
  }

  void getDataJadwalMengajar() async {
    Network network = Network();
    int idGuru = await getIdGuruFromSharedPreference();
    idGuru.toString();

    try {
      http.Response response =
          await network.getData('/jadwal-mengajar/$idGuru');

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        isLoading = false;

        List<JadwalMengajar> jadwalMengajarData = (responseData as List)
            .map((json) => JadwalMengajar.fromJson(json))
            .toList();

        setState(() {
          jadwalMengajarList = jadwalMengajarData;
          String status = 'Ada';
        });
      } else {
        print(
            'Gagal mengambil data jadwal mengajar. Status: ${response.statusCode}');
      }
    } catch (error) {
      print('Terjadi kesalahan: $error');
    }
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
              child: isLoading
                  ? Center(
                      child: Column(children: [
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(
                          strokeWidth: 5,
                          color: Colors.green,
                          backgroundColor: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text('Mengajar dimana hari ini?')
                    ]))
                  : PageView.builder(
                      itemCount: jadwalMengajarList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        JadwalMengajar currentClass = jadwalMengajarList[index];
                        // bool isDitinggalkan = currentClass.status == 'ditinggalkan';

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailMengajar(
                                  jamBelajar: currentClass.jamBelajar,
                                  kelas: currentClass.namaKelas,
                                  mataPelajaran: currentClass.namaMapel,
                                  jamMulai: currentClass.jamMulai,
                                  jamSelesai: currentClass.jamSelesai,
                                ),
                              ),
                            );
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: MediaQuery.of(context).size.width *
                                      1.0, // Menggunakan 80% lebar layar
                                  color: Colors.green[100],
                                  child: Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                                    currentClass.namaMapel,
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  currentClass.namaKelas,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 30),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                currentClass.jamMulai,
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Segera',
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
              itemCount: capaianJamList.length,
              itemBuilder: (BuildContext context, int index) {
                CapaianJam currentSubject = capaianJamList[index];
                double progress =
                    currentSubject.jamTercapai / currentSubject.targetCapaian;

                return Card(
                  child: Container(
                    padding: EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentSubject.namaMapel,
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
                          '${currentSubject.jamTercapai} / ${currentSubject.targetCapaian}',
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
