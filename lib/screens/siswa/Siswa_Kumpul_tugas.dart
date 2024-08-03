import 'package:flutter/material.dart';

class KumpulTugasSiswa extends StatefulWidget {
  const KumpulTugasSiswa({super.key});

  @override
  State<KumpulTugasSiswa> createState() => _KumpulTugasSiswaState();
}

class _KumpulTugasSiswaState extends State<KumpulTugasSiswa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              width: 50,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_new),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'IPAS - X TKJ 1',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Tugas 1',
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Pengembangan Sosial',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Jelaskan dan buatkan contoh penerapan pengembangan sosial pada lingkungan masyarakat indonesia yang saat ini masih dalam perkembangan.',
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Card(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Deadline',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            '20/10/2024',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          Text(
                                            '20 : 10',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 130,
                                      ),
                                      Text(
                                        '7 hours left',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.normal),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Tindakan yang dijalankan ketika tombol ditekan
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.yellow[700],
                                        padding: EdgeInsets.all(
                                            20), // Atur padding sesuai kebutuhan
                                        minimumSize: Size(200, 30),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                10)) // Atur ukuran minimum sesuai kebutuhan
                                        ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Berikan sedikit ruang antara ikon dan teks
                                        Text(
                                          'Upload Tugas',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        SizedBox(width: 8),
                                        Icon(
                                          Icons.upload_file,
                                          color: Colors.black,
                                        ), // Ganti dengan ikon yang diinginkan

                                        // Ganti dengan teks yang diinginkan
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ]),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
