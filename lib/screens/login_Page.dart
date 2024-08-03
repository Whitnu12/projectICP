import 'package:cobalagi2/screens/register_page.dart';
import 'package:cobalagi2/screens/guru/GuruLayout.dart';
import 'package:cobalagi2/screens/siswa/Siswa_Layout.dart';
import 'package:cobalagi2/util/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/api.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isObscurePassword = true;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  void _showMsg(String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState?.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 28, vertical: 72),
          child: Column(
            children: [
              SizedBox(
                height: 150,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/images/image_2.png'),
                    RichText(
                      text: TextSpan(
                        children: const <TextSpan>[
                          TextSpan(
                            text: ' E-Class ',
                            style: TextStyle(
                              color: Color.fromARGB(255, 42, 133, 45),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: ' \n SMKN 1 Kota Bima',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 18),
                    TextFormField(
                      controller: _emailController,
                      cursorColor: Colors.blue,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(color: Colors.black)),
                      validator: (emailValue) {
                        if (emailValue!.isEmpty) {
                          const snackbar = SnackBar(
                            content: Text("isi email mu!"),
                            backgroundColor: Colors.red,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: _passwordController,
                      cursorColor: Colors.blue,
                      obscureText: isObscurePassword,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  isObscurePassword = !isObscurePassword;
                                });
                              },
                              child: Icon(isObscurePassword
                                  ? Icons.lock
                                  : Icons.lock_open_rounded)),
                          suffixIconColor: Colors.green,
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.black)),
                      validator: (passwordValue) {
                        if (passwordValue!.isEmpty) {
                          const snackbar = SnackBar(
                            content: Text("isi password mu!"),
                            backgroundColor: Colors.red,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 12),
                    SizedBox(
                      width: 400,
                      height: 40,
                      child: ElevatedButton(
                        // ignore: sort_child_properties_last
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 100, vertical: 10),
                          child: _isLoading
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  'Login',
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[100],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _login();
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 12),
                    SizedBox(
                      width: 380,
                      height: 40,
                      child: ElevatedButton(
                        // ignore: sort_child_properties_last
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 100, vertical: 10),
                          child: _isLoading
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  'Register',
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Register()),
                          );
                        },
                      ),
                    ),
                    // ElevatedButton(
                    //   // ignore: sort_child_properties_last
                    //   child: Padding(
                    //     padding:
                    //         EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                    //     child: _isLoading
                    //         ? CircularProgressIndicator(
                    //             color: Colors.white,
                    //           )
                    //         : Text(
                    //             'Register',
                    //             textDirection: TextDirection.ltr,
                    //             style: TextStyle(
                    //               color: Colors.black,
                    //               fontSize: 15.0,
                    //               decoration: TextDecoration.none,
                    //               fontWeight: FontWeight.normal,
                    //             ),
                    //           ),
                    //   ),
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: Colors.grey[100],
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(20.0),
                    //     ),
                    //   ),
                    //   onPressed: () {
                    //     if (_formKey.currentState!.validate()) {
                    //       _login();
                    //     }
                    //   },
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    var email = _emailController.text;
    var password = _passwordController.text;

    var data = {'email': email, 'password': password};

    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        var response = await Network().auth(data, '/auth/login');

        var jsonResponse = json.decode(response.body);

        if (response.statusCode == 200) {
          SharedPreferences localStorage =
              await SharedPreferences.getInstance();
          localStorage.setString('token', jsonResponse['data']['token']);
          localStorage.setString(
              'user', json.encode(jsonResponse['data']['user']));

          String nis_nip = jsonResponse['data']['user']['nis_nip'];
          String name = jsonResponse['data']['user']['name'];
          String id = jsonResponse['data']['user']['id'].toString();

          AuthProvider.instance.setAuthData(
            token: jsonResponse['data']['token'],
            nisNip: nis_nip,
            idUser: id,
            name: name,
          );

          print('Data pengguna berhasil disimpan di shared preferences.');
          print('Nama: $name');
          print('NIS/NIP: $nis_nip');

          // Panjang yang diharapkan untuk NIS atau NIP
          int panjangNIS = 5;
          int panjangNIP = 15;

          if (nis_nip.length == panjangNIS) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => TenagaSpace()),
            );
          } else if (nis_nip.length == panjangNIP) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => GuruLayout()),
            );
          } else {
            _showMsg("Panjang nis_nip tidak sesuai");
          }
        } else {
          _showMsg(jsonResponse['message']);
          final snackBar = SnackBar(
            content: Text(jsonResponse['message']),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } catch (error) {
        // Handle connection error
        _showMsg("Tidak ada koneksi internet");
      } finally {
        // Stop loading in case of error
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
