import 'package:flutter/material.dart';

// import 'package:cobalagi2/network/api.dart';
class GuruHome extends StatefulWidget {
  @override
  _GuruHomeState createState() => _GuruHomeState();
}

class _GuruHomeState extends State<GuruHome> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // getDataJadwalMengajar();
    // getDataCapaianBelajar();
  }

  // Future<int> getIdGuruFromSharedPreference() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   int idGuru = prefs.getInt('idGuru') ?? 0;
  //   return idGuru;
  // }

  // void getDataCapaianBelajar() async {
  //   Network network = Network();
  //   int idGuru = await getIdGuruFromSharedPreference();
  //   idGuru.toString();

  //   try {
  //     http.Response response = await network.getData('/capaian-jam/$idGuru');

  //     if (response.statusCode == 200) {
  //       var responseData = jsonDecode(response.body);
  //       isLoading = false;

  //       List<CapaianJam> capaianJamData = (responseData['data'] as List)
  //           .map((json) => CapaianJam.fromJson(json))
  //           .toList();

  //       setState(() {
  //         capaianJamList = capaianJamData;
  //       });
  //     } else {
  //       print(
  //           'Gagal mengambil data capaian belajar. Status: ${response.statusCode}');
  //     }
  //   } catch (error) {
  //     print('Terjadi kesalahan: $error');
  //   }
  // }

  // void getDataJadwalMengajar() async {
  //   Network network = Network();
  //   int idGuru = await getIdGuruFromSharedPreference();
  //   idGuru.toString();

  //   try {
  //     http.Response response =
  //         await network.getData('/jadwal-mengajar/$idGuru');

  //     if (response.statusCode == 200) {
  //       var responseData = jsonDecode(response.body);
  //       isLoading = false;

  //       List<JadwalMengajar> jadwalMengajarData = (responseData as List)
  //           .map((json) => JadwalMengajar.fromJson(json))
  //           .toList();

  //       setState(() {
  //         jadwalMengajarList = jadwalMengajarData;
  //         String status = 'Ada';
  //       });
  //     } else {
  //       print(
  //           'Gagal mengambil data jadwal mengajar. Status: ${response.statusCode}');
  //     }
  //   } catch (error) {
  //     print('Terjadi kesalahan: $error');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(top: 20, start: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Mata Pelajaran',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Card(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 25,
                        ),
                        Expanded(
                          child: Text(
                            'IPAS - X TKJ 1',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Icon(
                          Icons.circle,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 25,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 25,
                        ),
                        Expanded(
                          child: Text(
                            'IPAS - XI TKJ 1',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Icon(
                          Icons.circle,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 25,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 25,
                        ),
                        Expanded(
                          child: Text(
                            'IPAS - XII TKJ 1',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Icon(
                          Icons.circle,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 25,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            ),
            // ListView.builder(
            //   itemCount: 2,
            //   shrinkWrap: true,
            //   itemBuilder: (BuildContext context, int index) {
            //     return Card(
            //       child: Container(
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             SizedBox(
            //               height: 25,
            //             ),
            //             Row(
            //               children: [
            //                 SizedBox(
            //                   width: 25,
            //                 ),
            //                 Expanded(
            //                   child: Text(
            //                     'IPAS - X TKJ 1',
            //                     style: TextStyle(fontWeight: FontWeight.bold),
            //                   ),
            //                 ),
            //                 Icon(
            //                   Icons.circle,
            //                   color: Colors.green,
            //                 ),
            //                 SizedBox(
            //                   width: 25,
            //                 )
            //               ],
            //             ),
            //             SizedBox(
            //               height: 25,
            //             ),
            //           ],
            //         ),
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
