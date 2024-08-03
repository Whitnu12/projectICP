import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String _token = '';
  String _nisNip = '';
  String _idUser = ''; // Menyimpan peran pengguna, misalnya 'siswa' atau 'guru'
  String _name = '';

  static AuthProvider instance = AuthProvider._(); // Singleton instance

  AuthProvider._(); // Constructor private

  String get token => _token;
  String get nisNip => _nisNip;
  String get idUser => _idUser;
  String get name => _name;

  void setAuthData({
    required String token,
    required String nisNip,
    required String idUser,
    required String name,
  }) {
    _token = token;
    _nisNip = nisNip;
    _idUser = idUser;
    _name = name;
    notifyListeners();
  }
}
