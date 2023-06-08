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

class _HomeScreenState extends State<HomeScreen> {
  List<JadwalMengajar> jadwalList = []; // Daftar jadwal mengajar
  Network network = Network();
  int idGuru = 0;

  @override
  void initState() {
    super.initState();
    fetchJadwalMengajar();
  }

  Future<void> fetchJadwalMengajar() async {
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      String guruData = localStorage.getString('guru') ?? "";
      Map<String, dynamic> guruJson = jsonDecode(guruData);
      Guru guru = Guru.fromJson(guruJson);

      if (guru.userId != null) {
        int idGuru = guru.idGuru;

        String apiURL =
            'http://192.168.100.6/laravel-icp2/public/api/jadwal-mengajar/$idGuru';
        http.Response response = await http.get(Uri.parse(apiURL));

        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);
          List<JadwalMengajar> tempList = [];

          for (var jadwal in jsonResponse['data']) {
            JadwalMengajar jadwalMengajar = JadwalMengajar.fromJson(jadwal);
            tempList.add(jadwalMengajar);
          }

          setState(() {
            jadwalList = tempList;
            print('Fetched Jadwal Mengajar:');
            for (var jadwal in jadwalList) {
              print(jadwal.namaMapel);
            }
          });
        } else {
          print('Failed to fetch data from API');
        }
      } else {
        print('Error: guru.userId is null');
      }
    } catch (error) {
      print('Error: $error');
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
              child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      width: 340,
                      child: Card(
                        color: Colors.green[100],
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          'Teknik Jaringan',
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'XII RPL 1',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                  width:
                                      16), // Jarak antara dua bagian dalam row
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '07.00 AM',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Mengajar',
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
                      ));
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
              itemCount:
                  10, // Ganti dengan jumlah data jadwal pelajaran esok hari
              itemBuilder: (BuildContext context, int index) {
                // Ganti dengan widget Card dan isi sesuai dengan data jadwal pelajaran esok hari
                return Card(
                  child: Container(
                    padding: EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Text(
                              'IPA',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                          ],
                        ),
                        SizedBox(height: 8),
                        LinearProgressIndicator(
                          color: Colors.green,
                          backgroundColor: Colors.greenAccent[100],
                          value: totalJamDiajar / targetJam,
                          minHeight: 10, // Hitung persentase progress
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          '$totalJamDiajar / $targetJam',
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
