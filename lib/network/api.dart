import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  final String _baseUrl = 'http://192.168.100.6/laravel-icp2/public/api';

  Future<http.Response> auth(Map<String, dynamic> data, String apiURL) async {
    var fullUrl = '$_baseUrl$apiURL';
    return await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(data),
      headers: await _setHeaders(),
    );
  }

  Future<Map<String, dynamic>> buatMapel({
    required String namaMapel,
    required String enrollCode,
    required String idUser,
  }) async {
    var fullUrl = '$_baseUrl/mata-pelajaran/add';
    var headers = await _setHeaders();

    // Konversi idUser ke integer
    int idGuru = int.parse(idUser);

    var data = {
      'nama_mapel': namaMapel,
      'enroll_code': enrollCode,
      'idUser': idGuru, // Menggunakan id_guru yang sudah diubah ke integer
    };

    var response = await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(data),
      headers: headers,
    );

    return jsonDecode(response.body);
  }

  Future<http.Response> getData(String apiURL) async {
    var fullUrl = '$_baseUrl$apiURL';
    return await http.get(
      Uri.parse(fullUrl),
      headers: await _setHeaders(),
    );
  }

  Future<Map<String, String>> _setHeaders() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? token = localStorage.getString('token');
    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<http.Response> sendMultiPartRequest(
    String apiURL,
    Map<String, String> fields,
    List<http.MultipartFile> files,
  ) async {
    var fullUrl = '$_baseUrl$apiURL';
    var request = http.MultipartRequest('POST', Uri.parse(fullUrl));
    request.headers.addAll(await _setHeaders());

    request.fields.addAll(fields);

    for (var file in files) {
      request.files.add(file);
    }

    var response = await request.send();
    return await http.Response.fromStream(response);
  }
}
