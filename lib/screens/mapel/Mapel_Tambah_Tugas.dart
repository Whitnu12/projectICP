import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TambahTugas extends StatefulWidget {
  const TambahTugas({super.key});

  @override
  State<TambahTugas> createState() => _TambahTugasState();
}

class _TambahTugasState extends State<TambahTugas> {
  final TextEditingController _namaMapelController = TextEditingController();
  final TextEditingController _deskripsiMapelController =
      TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

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
                    "Tambah Tugas",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _namaMapelController,
                    decoration: InputDecoration(labelText: 'Nama Tugas'),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _deskripsiMapelController,
                    decoration: InputDecoration(labelText: 'Deskripsi Tugas'),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () => _selectDateTime(context),
                    child: Text('Pilih Deadline'),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Deadline: ${_formattedDateTime()}',
                    style: TextStyle(fontSize: 16),
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
                            _TambahTugas(context);
                          },
                          child: Text('Buat Tugas'),
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

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );

          _selectedTime = pickedTime;
        });
      }
    }
  }

  void _TambahTugas(BuildContext context) {
    String namaMapel = _namaMapelController.text;
    String deskripsiMapel = _deskripsiMapelController.text;

    // Lakukan apa pun yang diperlukan dengan data yang telah diambil
    // Misalnya, kirim data ini ke backend atau lakukan validasi lainnya

    // Kembali ke halaman sebelumnya

    if (_selectedDate != null && _selectedTime != null) {
      // Anda dapat menggunakan _selectedDate dan _selectedTime di sini
      // Lakukan apa pun yang diperlukan dengan data yang telah diambil
      // Misalnya, kirim data ini ke backend atau lakukan validasi lainnya

      // Kembali ke halaman sebelumnya
      Navigator.pop(context);
    } else {
      // Tampilkan pesan kesalahan jika deadline belum dipilih
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Pilih deadline terlebih dahulu.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      Navigator.pop(context);
    }
  }

  String? _formattedDateTime() {
    if (_selectedDate != null && _selectedTime != null) {
      final formattedDate = DateFormat.yMMMMd('en_US').format(_selectedDate!);
      final formattedTime = DateFormat.jm().format(DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      ));

      return '$formattedDate, $formattedTime';
    }
    return null;
  }
}
