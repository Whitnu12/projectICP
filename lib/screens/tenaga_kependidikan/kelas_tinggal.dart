import 'package:flutter/material.dart';
import 'dart:async';
import 'package:percent_indicator/circular_percent_indicator.dart';

class KelasTinggal extends StatefulWidget {
  final String kelas;
  final String mataPelajaran;
  final int jamPelajaran;
  final TimeOfDay jamMulai;

  KelasTinggal({
    required this.kelas,
    required this.mataPelajaran,
    required this.jamPelajaran,
    required this.jamMulai,
  });

  @override
  State<KelasTinggal> createState() => _KelasTinggalState();
}

class _KelasTinggalState extends State<KelasTinggal> {
  Stopwatch _stopwatch = Stopwatch();
  bool _isClassLeft = true;
  String _leaveReason = 'Ada Rapat Pusat di Jakarta';
  String get formattedJamMulai {
    return '${widget.jamMulai.hour.toString().padLeft(2, '0')}:${widget.jamMulai.minute.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(text: ' Mengajar \n'),
                    TextSpan(
                      text: ' ${widget.mataPelajaran}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: EdgeInsets.only(left: 0),
            child: Text(
              'Hari ini',
              style: TextStyle(fontSize: 24),
            ),
          ),
          SizedBox(
            height: 600,
            child: Card(
              color: _isClassLeft ? Colors.red[100] : Colors.green[100],
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ' ${widget.kelas}',
                              style: TextStyle(
                                  fontSize: 34, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ' ${widget.mataPelajaran}',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        Text(
                          ' $formattedJamMulai ',
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                    SizedBox(height: 80),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _isClassLeft
                          ? [
                              Text(
                                'Pesan Untuk Anda',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
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
                    SizedBox(height: 32),
                    SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('Isi Kelas'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.only(top: 15, bottom: 15)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Card(
            child: Container(
              padding: EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ' ${widget.mataPelajaran}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  LinearProgressIndicator(
                    color: Colors.green,
                    backgroundColor: Colors.greenAccent[100],
                    value: 20 / 60,
                    minHeight: 10,
                  ),
                  SizedBox(height: 4),
                  Text(
                    '20 / 60',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ))));
  }
}
