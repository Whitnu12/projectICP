import 'package:flutter/material.dart';

class KuisMulai extends StatefulWidget {
  const KuisMulai({super.key});

  @override
  State<KuisMulai> createState() => _KuisMulaiState();
}

class _KuisMulaiState extends State<KuisMulai> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                          'Peredaran Darah dan Kardiovaskular',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Kuis 2',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Card(
                          color: Colors.green,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment
                                  .end, // Align content at the bottom
                              crossAxisAlignment: CrossAxisAlignment
                                  .stretch, // Stretch content horizontally
                              children: [
                                Text(
                                  'Baca Aturan Kuis!',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  '1. Jangan melakukan hal bodoh',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  '2. Baca soal dengan cermat',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  '3. Pilih Jawaban paling benar',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  height: 2,
                                ),

                                SizedBox(
                                    height:
                                        16), // Add some space between text and button
                                ElevatedButton(
                                  onPressed: () {
                                    // Handle button press (e.g., navigate to quiz screen)
                                  },
                                  child: Text('Mulai Kuis'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: Stack(
      //   children: [
      //     Positioned(
      //       bottom: 16,
      //       child: ElevatedButton(
      //         onPressed: () {},
      //         child: Text('Bottom Button'),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
