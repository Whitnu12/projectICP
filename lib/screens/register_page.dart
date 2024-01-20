import 'dart:convert';

import 'package:cobalagi2/network/api.dart';
import 'package:cobalagi2/screens/login_Page.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  void _showMsg(String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState?.showSnackBar(snackBar);
  }

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  TextEditingController _namaController = TextEditingController();
  TextEditingController _nisNipController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 72),
        child: Column(children: [
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(height: 70),
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
            SizedBox(height: 20),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _namaController,
                      cursorColor: Colors.blue,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          hintText: "Nama",
                          hintStyle: TextStyle(color: Colors.black)),
                      validator: (emailValue) {
                        if (emailValue!.isEmpty) {
                          const snackbar = SnackBar(
                            content: Text("isi nama mu!"),
                            backgroundColor: Colors.red,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _nisNipController,
                      cursorColor: Colors.blue,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          hintText: "NIP/NIS",
                          hintStyle: TextStyle(color: Colors.black)),
                      validator: (emailValue) {
                        if (emailValue!.isEmpty) {
                          const snackbar = SnackBar(
                            content: Text("isi nama mu!"),
                            backgroundColor: Colors.red,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
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
                            content: Text("isi nama mu!"),
                            backgroundColor: Colors.red,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      cursorColor: Colors.blue,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.black)),
                      validator: (emailValue) {
                        if (emailValue!.isEmpty) {
                          const snackbar = SnackBar(
                            content: Text("isi nama mu!"),
                            backgroundColor: Colors.red,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        }
                        return null;
                      },
                    ),
                  ],
                )),
            SizedBox(height: 20),
            SizedBox(
              width: 380,
              height: 40,
              child: ElevatedButton(
                // ignore: sort_child_properties_last
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
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
                  if (_formKey.currentState!.validate()) {
                    _register();
                  }
                },
              ),
            ),
            SizedBox(
              height: 12,
            ),
            SizedBox(
              width: 380,
              height: 40,
              child: ElevatedButton(
                // ignore: sort_child_properties_last
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                  child: Text(
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
                  backgroundColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
              ),
            ),
          ])
        ]),
      )),
    );
  }

  void _register() async {
    setState(() {
      _isLoading = true;
    });

    var nama = _namaController.text;
    var nisNip = _nisNipController.text;
    var email = _emailController.text;
    var password = _passwordController.text;

    var data = {
      'name': nama,
      'nis_nip': nisNip,
      'email': email,
      'password': password,
    };

    if (nama.isNotEmpty &&
        nisNip.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty) {
      var response = await Network().auth(data, '/auth/register');

      var jsonResponse = json.decode(response.body);

      if (response.statusCode == 201) {
        // Registrasi sukses, lanjutkan ke halaman login atau beri pesan sukses
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } else {
        // Tampilkan pesan error dari server
        if (jsonResponse['message'] is String) {
          _showMsg(jsonResponse['message']);
        } else if (jsonResponse['message'] is Map<String, dynamic> &&
            jsonResponse['message']['error'] is String) {
          _showMsg(jsonResponse['message']['error']);
        } else {
          _showMsg("Terjadi kesalahan pada server");
        }
      }
    } else {
      // Tampilkan pesan jika ada field yang kosong
      _showMsg("Semua field harus diisi");
    }

    setState(() {
      _isLoading = false;
    });
  }
}
