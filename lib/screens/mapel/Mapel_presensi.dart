import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PresensiSiswa {
  final String nama;
  final String nis;
  String? kodePresensi;
  String status;

  PresensiSiswa({
    required this.nama,
    required this.nis,
    this.kodePresensi,
    this.status = 'Belum hadir',
  });

  set tanggalPresensi(DateTime tanggalPresensi) {}
}

class MapelPresensi extends StatefulWidget {
  const MapelPresensi({Key? key}) : super(key: key);

  @override
  State<MapelPresensi> createState() => _MapelPresensiState();
}

class _MapelPresensiState extends State<MapelPresensi> {
  List<PresensiSiswa> siswaList = [
    PresensiSiswa(nama: 'Adimas', nis: '17415'),
    PresensiSiswa(nama: 'Arifin', nis: '17421'),
    PresensiSiswa(nama: 'Novita', nis: '17436'),
    PresensiSiswa(nama: 'Magfira', nis: '17432'),
    PresensiSiswa(nama: 'Nuramelia', nis: '17437'),
  ];

  get iconColor => null;

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
            SizedBox(height: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Presensi Siswa",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "IPAS - X TKJ 1",
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Kode Presensi",
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "ZXCVB",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 25,
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: siswaList.length,
                itemBuilder: (context, index) {
                  PresensiSiswa siswa = siswaList[index];
                  return ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${siswa.nama}'),
                        Text('${siswa.nis}'),
                      ],
                    ),
                    subtitle: Text(
                      '${siswa.status}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(_getStatusIcon(siswa.status)),
                    onTap: () {
                      _showStatusOptions(context, siswa);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void presensiOtomatis() {
    // Implementasi untuk presensi otomatis
    // Misalnya, generate kode presensi dan set status siswa menjadi "Hadir"
    setState(() {
      // Simulasikan data presensi otomatis
      for (PresensiSiswa siswa in siswaList) {
        siswa.status = 'Hadir';
        siswa.tanggalPresensi = DateTime.now();
      }
    });
  }

  void _showStatusOptions(BuildContext context, PresensiSiswa siswa) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                title: Text('Hadir'),
                onTap: () {
                  _updateStatus(context, siswa, 'Hadir');
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.sick,
                  color: Colors.yellow[700],
                ),
                title: Text('Sakit'),
                onTap: () {
                  _updateStatus(context, siswa, 'Sakit');
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.access_time,
                  color: Colors.blue,
                ),
                title: Text('Izin'),
                onTap: () {
                  _updateStatus(context, siswa, 'Izin');
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.close,
                  color: Colors.red,
                ),
                title: Text('Alpa'),
                onTap: () {
                  _updateStatus(context, siswa, 'Alpa');
                },
              ),
              ListTile(
                leading: Icon(Icons.cancel),
                title: Text('Bolos'),
                onTap: () {
                  _updateStatus(context, siswa, 'Bolos');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _updateStatus(
      BuildContext context, PresensiSiswa siswa, String status) async {
    Navigator.pop(context);

    // Panggil fungsi atau API untuk memperbarui status di server
    try {
      // Ganti URL_API dengan URL API Anda
      final url = 'URL_API/update_status';

      // Ganti dengan data atau payload yang sesuai untuk memperbarui status
      final data = {
        // 'id_siswa': siswa.idSiswa,
        'status': status,
        // 'id_mapel' ; IdMapel,
        // Tambahan data lain yang mungkin diperlukan
      };

      final response = await http.post(Uri.parse(url), body: data);

      if (response.statusCode == 200) {
        // Jika pembaruan berhasil, perbarui status di dalam setState
        setState(() {
          siswa.status = status;
          siswa.tanggalPresensi = DateTime.now();
        });

        print('Status berhasil diperbarui di server');
      } else {
        print(
            'Gagal memperbarui status di server. Status: ${response.statusCode}');
      }
    } catch (error) {
      print('Terjadi kesalahan: $error');
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'hadir':
        return Icons.check;
      case 'sakit':
        return Icons.sick;
      case 'izin':
        return Icons.access_time;
      case 'alpa':
        return Icons.close;
      case 'bolos':
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }

  Widget _buildStatusIcon(String status) {
    return Icon(
      _getStatusIcon(status),
      color: iconColor,
    );
  }

  void main() {
    runApp(MaterialApp(
      home: MapelPresensi(),
    ));
  }
}
