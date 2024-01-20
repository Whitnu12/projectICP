import 'package:flutter/material.dart';

class TambahMapel extends StatefulWidget {
  const TambahMapel({Key? key}) : super(key: key);

  @override
  State<TambahMapel> createState() => _TambahMapelState();
}

class _TambahMapelState extends State<TambahMapel> {
  final TextEditingController _namaMapelController = TextEditingController();
  final TextEditingController _deskripsiMapelController =
      TextEditingController();
  final TextEditingController _enrollCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
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
                  Text(
                    "Tambah Mata Pelajaran",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _namaMapelController,
                    decoration: InputDecoration(labelText: 'Nama Mapel'),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _deskripsiMapelController,
                    decoration: InputDecoration(labelText: 'Deskripsi Mapel'),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _enrollCodeController,
                    decoration: InputDecoration(labelText: 'Enroll Code'),
                  ),
                  // Spacer ditambahkan di sini
                  SizedBox(height: 32.0),
                  Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(bottom: 16.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: 500,
                        height: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green, // Ganti warna latar belakang
                            onPrimary: Colors.white, // Ganti warna teks
                          ),
                          onPressed: () {
                            _buatMapel(context);
                          },
                          child: Text('Buat Mapel'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _buatMapel(BuildContext context) {
  // Mengambil informasi guru yang sedang login
  String idGuru = AuthProvider.instance.idUser;
  String namaGuru = AuthProvider.instance.namaGuru;

  String namaMapel = _namaMapelController.text;
  String deskripsiMapel = _deskripsiMapelController.text;
  String enrollCode = _enrollCodeController.text;

  // Memastikan semua data yang diperlukan tersedia
  if (namaMapel.isNotEmpty && enrollCode.isNotEmpty) {
    // Membuat permintaan API untuk menambahkan mata pelajaran
    ApiService().buatMapel(
      namaMapel: namaMapel,
      deskripsiMapel: deskripsiMapel,
      enrollCode: enrollCode,
      id: idUser,
      namaGuru: namaGuru,
    ).then((response) {
      // Memproses respons dari permintaan API
      if (response['status'] == 'success') {
        // Jika sukses, kembali ke halaman sebelumnya
        Navigator.pop(context);
      } else {
        // Jika gagal, tampilkan pesan kesalahan
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'])),
        );
      }
    });
  } else {
    // Menampilkan pesan jika data tidak lengkap
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Semua kolom harus diisi')),
    );
  }
}
}
