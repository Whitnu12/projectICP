import 'package:cobalagi2/screens/siswa/Siswa_Kumpul_tugas.dart';
import 'package:flutter/material.dart';

class SiswaListTugas extends StatefulWidget {
  const SiswaListTugas({super.key});

  @override
  State<SiswaListTugas> createState() => _SiswaListTugasState();
}

class _SiswaListTugasState extends State<SiswaListTugas> {
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
                        'Tugas',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'IPAS - X TKJ 1',
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Card(
                        color: Colors.green,
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => KumpulTugasSiswa()),
                            );
                          },
                          title: Text(
                            'Pengembangan Sosial ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 21,
                                color: Colors.white),
                          ),
                          subtitle: Text(
                            'Tugas 1',
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: Text(
                            '89',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.green,
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => KumpulTugasSiswa()),
                            );
                          },
                          title: Text(
                            'Peredaran Darah dan Kardiovaskular',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 21,
                                color: Colors.white),
                          ),
                          subtitle: Text(
                            'Tugas 2',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
