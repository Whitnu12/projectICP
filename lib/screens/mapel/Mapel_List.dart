import 'package:cobalagi2/screens/mapel/Mapel_Detail.dart';
import 'package:cobalagi2/screens/mapel/tambah_mapel.dart';
import 'package:flutter/material.dart';

class MapelList extends StatefulWidget {
  const MapelList({super.key});

  @override
  State<MapelList> createState() => _MapelListState();
}

class _MapelListState extends State<MapelList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsetsDirectional.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(text: 'Mata Pelajaran\n'),
                      ],
                    ),
                  ),
                ],
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MapelDetail()),
                    );
                  },
                  title: Text(
                    'IPAS-XI TKJ 1',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                    ),
                  ),
                  trailing: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MapelDetail()),
                    );
                  },
                  title: Text(
                    'IPAS-XII TKJ 1',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                    ),
                  ),
                  trailing: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MapelDetail()),
                    );
                  },
                  title: Text(
                    'IPAS-X TKJ 1',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                    ),
                  ),
                  trailing: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TambahMapel()),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
