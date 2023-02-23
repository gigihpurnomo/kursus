import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kursus/firebase_options.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';

class tabelScreen extends StatefulWidget {
  const tabelScreen({super.key});

  @override
  _TablePageState createState() => _TablePageState();
}

class _TablePageState extends State<tabelScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late QuerySnapshot querySnapshot;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });

    querySnapshot = await firestore.collection('LPDP').get();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabel Data calon Siswa'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Nama')),
                    DataColumn(label: Text('Alamat')),
                    DataColumn(label: Text('No. HP')),
                    DataColumn(label: Text('Jenis Kelamin')),
                    DataColumn(label: Text('Lokasi')),
                    DataColumn(label: Text('Foto')),
                  ],
                  rows: querySnapshot.docs
                      .map((document) => DataRow(cells: [
                            DataCell(Text(document['nama'])),
                            DataCell(Text(document['address'])),
                            DataCell(Text(document['number'])),
                            DataCell(Text(document['_JK'])),
                            DataCell(Text(document['_Location'])),
                              DataCell(FutureBuilder<String>(
                                future: FirebaseStorage.instance
                                    .ref()
                                    .child('LPDP')
                                    .child(document['nama'] + '.jpg')
                                    .getDownloadURL(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Image.network(snapshot.data!);
                                  } else if (snapshot.hasError) {
                                    return Text('Error : ${snapshot.error}');
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                },
                              )),
                            ],
                          ))
                      .toList(),
                ),
              ),
      ),
    );
  }
}