import 'package:cobalagi2/screens/second_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/guruProfile.dart';

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
      backgroundColor: Colors.green[100],
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
                            text: ' E-Manage ',
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
                    ElevatedButton(
                      // ignore: sort_child_properties_last
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 75, vertical: 10),
                        child: Text(
                          _isLoading ? 'Processing..' : 'Login',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[500],
                        foregroundColor: Colors.grey[700],
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
                  ],
                ),
              )
              //   Card(
              //     elevation: 4.0,
              //     color: Colors.white10,
              //     margin: EdgeInsets.only(top: 86),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(14),
              //     ),
              //     child: Padding(
              //       padding: EdgeInsets.all(24),
              //       child: Form(
              //         key: _formKey,
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Text(
              //               "Login",
              //               textAlign: TextAlign.center,
              //               style: TextStyle(
              //                 color: Colors.white,
              //                 fontSize: 24,
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             ),
              //             SizedBox(height: 18),
              //             TextFormField(
              //               controller: _emailController,
              //               cursorColor: Colors.blue,
              //               keyboardType: TextInputType.text,
              //               style: TextStyle(color: Colors.white),
              //               decoration: InputDecoration(
              //                   hintText: "Email",
              //                   hintStyle: TextStyle(color: Colors.white)),
              //               validator: (emailValue) {
              //                 if (emailValue!.isEmpty) {
              //                   return 'Please enter your email';
              //                 }
              //                 return null;
              //               },
              //             ),
              //             SizedBox(height: 12),
              //             TextFormField(
              //               controller: _passwordController,
              //               cursorColor: Colors.blue,
              //               keyboardType: TextInputType.text,
              //               obscureText: true,
              //               style: TextStyle(color: Colors.white),
              //               decoration: InputDecoration(
              //                   hintText: "Password",
              //                   hintStyle: TextStyle(color: Colors.white)),
              //               validator: (passwordValue) {
              //                 if (passwordValue!.isEmpty) {
              //                   return 'Please enter your password';
              //                 }
              //                 return null;
              //               },
              //             ),
              //             SizedBox(height: 12),
              //             ElevatedButton(
              //               // ignore: sort_child_properties_last
              //               child: Padding(
              //                 padding: EdgeInsets.symmetric(
              //                     horizontal: 18, vertical: 10),
              //                 child: Text(
              //                   _isLoading ? 'Processing..' : 'Login',
              //                   textDirection: TextDirection.ltr,
              //                   style: TextStyle(
              //                     color: Colors.white,
              //                     fontSize: 18.0,
              //                     decoration: TextDecoration.none,
              //                     fontWeight: FontWeight.normal,
              //                   ),
              //                 ),
              //               ),
              //               style: ElevatedButton.styleFrom(
              //                 primary: Colors.blueAccent,
              //                 onSurface: Colors.grey,
              //                 shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(20.0),
              //                 ),
              //               ),
              //               onPressed: () {
              //                 if (_formKey.currentState!.validate()) {
              //                   _login();
              //                 }
              //               },
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
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
      var response = await http.post(
        Uri.parse('http://192.168.100.6/laravel-icp2/public/api/auth/login'),
        body: json.encode(data),
        headers: {'Content-Type': 'application/json'},
      );

      var jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('token', jsonResponse['data']['token']);
        localStorage.setString(
            'user', json.encode(jsonResponse['data']['user']));

        // Simpan profil pengguna ke SharedPreferences
        _loadUserData();

        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SecondPage()),
        );
      } else {
        _showMsg(jsonResponse['message']);
        final snackBar = SnackBar(
          content: Text(jsonResponse['message']),
          backgroundColor: Colors.red,
        );
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  Guru? userProfile;
  void _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? userDataJson = localStorage.getString('user');
    String? guruDataJson = localStorage.getString('guru');

    if (userDataJson != null && guruDataJson != null) {
      var userData = jsonDecode(userDataJson);
      var guruData = jsonDecode(guruDataJson);

      print('User Data: $userData');
      print('Guru Data: $guruData');

      setState(() {
        userProfile = Guru(
          userId: userData['data']['user']['id'],
          nama: userData['data']['user']['name'],
          npp: guruData['NPP'],
          email: userData['data']['user']['email'],
          password: guruData['password'],
          jabatan: guruData['jabatan'],
          fotoProfil: guruData['foto_profil'],
          createdAt: DateTime.parse(userData['data']['user']['created_at']),
          updatedAt: DateTime.parse(userData['data']['user']['updated_at']),
        );
      });
    }
  }
}
