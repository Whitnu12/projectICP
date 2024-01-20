// import 'dart:convert';
// import 'package:cobalagi2/network/api.dart';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
// import 'package:path/path.dart' as path;
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../model/guruProfile.dart';

// class LaporanPendidikan extends StatefulWidget {
//   @override
//   _LaporanPendidikanState createState() => _LaporanPendidikanState();
// }

// class _LaporanPendidikanState extends State<LaporanPendidikan> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _namaKegiatanController = TextEditingController();
//   final TextEditingController _deskripsiController = TextEditingController();
//   String? _selectedDate;
//   List<File?> _imageFiles = [];

// // Mendapatkan nilai idGuru dari shared preference
//   Future<int> getIdGuruFromSharedPreference() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     int idGuru = prefs.getInt('idGuru') ?? 0;
//     return idGuru;
//   }

//   void _submitForm() async {
//     // Validate form fields
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }

//     // Prepare data for the request
//     String namaKegiatan = _namaKegiatanController.text;
//     String deskripsi = _deskripsiController.text;
//     String jenisLaporan = '1';

//     int idGuru = await getIdGuruFromSharedPreference();

//     // Prepare request data
//     Map<String, String> fields = {
//       'judul_laporan': namaKegiatan,
//       'deskripsi_laporan': deskripsi,
//       'id_jenis': jenisLaporan,
//       'id_guru': idGuru.toString(),
//       'tanggal': _selectedDate!,
//     };

//     List<http.MultipartFile> files = [];
//     for (var file in _imageFiles) {
//       if (file != null) {
//         String fileName = path.basename(file.path);
//         files.add(await http.MultipartFile.fromPath(
//           'gambar[]',
//           file.path,
//           filename: fileName,
//           contentType: MediaType(
//             'image',
//             'jpeg',
//           ),
//         ));
//       }
//     }

//     try {
//       final response = await Network().sendMultiPartRequest(
//         '/laporan/create',
//         fields,
//         files,
//       );

//       if (response.statusCode == 201) {
//         // Request successful
//         // Show success message
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Laporan kegiatan berhasil dikirim'),
//             backgroundColor: Colors.green,
//           ),
//         );
//         // Clear form fields and image files
//         _namaKegiatanController.clear();
//         _deskripsiController.clear();
//         setState(() {
//           _selectedDate = null;
//           _imageFiles.clear();
//         });
//       } else {
//         // Request failed
//         // Show error message with response information
//         String errorMessage = 'Gagal mengirim laporan kegiatan';
//         if (response.body != null) {
//           var errorJson = json.decode(response.body);
//           if (errorJson is Map<String, dynamic>) {
//             errorJson.forEach((key, value) {
//               errorMessage += '\n$key: ${value[0]}';
//             });
//           }
//         }
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(errorMessage)),
//         );
//       }
//     } catch (e) {
//       // Error occurred during the request
//       print('Error: $e');
//       // Show error message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Terjadi kesalahan')),
//       );
//     }
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//     );

//     if (picked != null && picked != _selectedDate) {
//       setState(() {
//         final DateFormat formatter = DateFormat('dd/MM/yyyy');
//         _selectedDate = formatter.format(picked);
//       });
//     }
//   }

//   void _pickImage() async {
//     final pickedImage =
//         await ImagePicker().getImage(source: ImageSource.gallery);

//     if (pickedImage != null) {
//       setState(() {
//         _imageFiles.add(File(pickedImage.path));
//       });
//     }
//   }

//   void _deleteImage(int index) {
//     setState(() {
//       _imageFiles.removeAt(index);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       IconButton(
//                         icon: Icon(Icons.arrow_back),
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                       ),
//                       RichText(
//                         text: TextSpan(
//                           style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                           children: [
//                             TextSpan(text: 'Laporan\n'),
//                             TextSpan(
//                               text: 'Pendidikan',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.normal,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     'Nama kegiatan',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   TextFormField(
//                     controller: _namaKegiatanController,
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Masukkan nama kegiatan';
//                       }
//                       return null;
//                     },
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: 'Masukkan nama kegiatan',
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     'Tanggal Kegiatan',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   GestureDetector(
//                     onTap: () {
//                       _selectDate(context);
//                     },
//                     child: AbsorbPointer(
//                       child: TextFormField(
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(),
//                           hintText: 'Pilih tanggal kegiatan',
//                         ),
//                         controller: TextEditingController(
//                           text: _selectedDate != null ? '$_selectedDate' : '',
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     'Apa yang Terjadi',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   TextFormField(
//                     controller: _deskripsiController,
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Masukkan deskripsi';
//                       }
//                       return null;
//                     },
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: 'Masukkan deskripsi',
//                     ),
//                     maxLines: 5,
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     'Foto Kegiatan',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Container(
//                     height: 200,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: _imageFiles.length + 1,
//                       itemBuilder: (context, index) {
//                         if (index == _imageFiles.length) {
//                           return GestureDetector(
//                             onTap: _pickImage,
//                             child: Container(
//                               width: 150,
//                               margin: EdgeInsets.only(right: 8),
//                               decoration: BoxDecoration(
//                                 border: Border.all(color: Colors.grey),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Icon(
//                                 Icons.add,
//                                 size: 48,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           );
//                         } else {
//                           return Stack(
//                             children: [
//                               Container(
//                                 width: 150,
//                                 margin: EdgeInsets.only(right: 8),
//                                 decoration: BoxDecoration(
//                                   border: Border.all(color: Colors.grey),
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(8),
//                                   child: Image.file(
//                                     _imageFiles[index]!,
//                                     width: double.infinity,
//                                     height: double.infinity,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                               Positioned(
//                                 top: 8,
//                                 right: 8,
//                                 child: GestureDetector(
//                                   onTap: () => _deleteImage(index),
//                                   child: CircleAvatar(
//                                     radius: 12,
//                                     backgroundColor: Colors.red,
//                                     child: Icon(
//                                       Icons.close,
//                                       size: 16,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           );
//                         }
//                       },
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   Container(
//                     width: double.infinity, // Lebar Container
//                     child: ElevatedButton(
//                       style: ButtonStyle(
//                         fixedSize:
//                             MaterialStateProperty.all(Size.fromHeight(40)),
//                         backgroundColor:
//                             MaterialStateProperty.all(Colors.green),
//                       ),
//                       onPressed: () {
//                         _submitForm();
//                       },
//                       child: SizedBox(
//                         width:
//                             double.infinity, // Sesuaikan dengan lebar Container
//                         child: Text('Kirim',
//                             textAlign: TextAlign.center, // Menengahkan teks
//                             style: TextStyle(fontSize: 16)),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
