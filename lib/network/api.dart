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
}
