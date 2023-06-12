import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DetailMengajar extends StatefulWidget {
  final String kelas;
  final String mataPelajaran;
  final int jamPelajaran;
  final TimeOfDay jamMulai;

  DetailMengajar({
    required this.kelas,
    required this.mataPelajaran,
    required this.jamPelajaran,
    required this.jamMulai,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DetailMengajarState createState() => _DetailMengajarState();
}

class _DetailMengajarState extends State<DetailMengajar> {
  Stopwatch _stopwatch = Stopwatch();
  bool _isRunning = false;
  Timer? _timer;
  int _maxValue = 0;
  bool _isClassLeft = false;
  String _leaveReason = '';
  String get formattedJamMulai {
    return '${widget.jamMulai.hour.toString().padLeft(2, '0')}:${widget.jamMulai.minute.toString().padLeft(2, '0')}';
  }

  void _showLeaveClassDialog() {
    String reason = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tinggalkan Kelas'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Masukkan alasan Anda untuk meninggalkan kelas:'),
              TextField(
                onChanged: (value) {
                  reason = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (reason.isNotEmpty) {
                  _stopStopwatch();
                  Navigator.of(context).pop();
                  setState(() {
                    _isRunning = false;
                    _isClassLeft = true;
                    _leaveReason =
                        reason; // Simpan alasan di variabel _leaveReason
                  });
                }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _setMaxValue();
    _startTimer();
  }

  void _setMaxValue() {
    _maxValue = widget.jamPelajaran * 45;
  }

  void _startStopwatch() {
    setState(() {
      _stopwatch.start();
      _isRunning = true;
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {});
      });
    });
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          if (_getProgressValue() >= _maxValue) {
            timer.cancel();
          }
        });
      },
    );
  }

  int _getProgressValue() {
    final int progressMinutes = _stopwatch.elapsed.inMinutes;
    final int totalMinutes = widget.jamPelajaran * 45;
    return progressMinutes > totalMinutes ? totalMinutes : progressMinutes;
  }

  void _stopStopwatch() {
    setState(() {
      _stopwatch.stop();
      _isRunning = false;
      _timer?.cancel();
    });
  }

  double _getProgressPercent() {
    final int progressMinutes = _getProgressValue();
    final int totalMinutes = widget.jamPelajaran * 45;
    return progressMinutes / totalMinutes;
  }

  Color _getProgressColor() {
    final double progressPercent = _getProgressPercent();
    final Color startColor = Colors.blue; // Warna awal
    final Color endColor = Colors.green; // Warna akhir

    return Color.lerp(startColor, endColor, progressPercent)!;
  }

  String _formatTime(Duration duration) {
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);
    return "$minutes:${seconds.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    _stopwatch.stop();
    _timer?.cancel();
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
                                _leaveReason,
                                style: TextStyle(fontSize: 24),
                              ),
                            ]
                          : [
                              CircularPercentIndicator(
                                radius: 150,
                                lineWidth: 20,
                                percent: _getProgressPercent(),
                                center: Text(
                                  '${_formatTime(_stopwatch.elapsed)}',
                                  style: TextStyle(fontSize: 32),
                                ),
                                progressColor: Colors.green,
                                backgroundColor: Colors.green.shade300,
                              ),
                            ],
                    ),
                    SizedBox(height: 32),
                    SizedBox(height: 16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _isClassLeft
                                ? null
                                : (_isRunning
                                    ? _showLeaveClassDialog
                                    : _startStopwatch),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.only(top: 15, bottom: 15),
                              backgroundColor:
                                  _isClassLeft ? Colors.red : Colors.green,
                            ),
                            child: Text(
                              _isClassLeft
                                  ? 'Kelas Ditinggalkan'
                                  : (_isRunning
                                      ? 'Tinggalkan Kelas'
                                      : 'Mulai Mengajar'),
                              style: TextStyle(fontSize: 16),
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
