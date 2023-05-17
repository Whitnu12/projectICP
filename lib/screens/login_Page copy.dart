// import 'package:cobalagi2/screens/second_page%20copy.dart';
// import 'package:cobalagi2/screens/second_page.dart';
// import 'package:flutter/material.dart';
// import '../auth.dart';

// class LoginPage extends StatefulWidget {
//   LoginPage({Key? key}) : super(key: key);
//   // final Path _auth = Auth();
//   @override
//   // ignore: library_private_types_in_public_api
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _isLoading = false;

//   void _login() async {
//     setState(() {
//       _isLoading = true;
//     });

//     final email = _emailController.text;
//     final password = _passwordController.text;

//     try {
//       await widget._auth.signinWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       final isLoggedIn = await widget._auth.isLoggedIn();

//       if (isLoggedIn) {
//         // ignore: use_build_context_synchronously
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => SecondPage()),
//         );
//       } else {
//         // ignore: use_build_context_synchronously
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text('Login Failed'),
//               content: Text('Invalid email or password.'),
//               actions: <Widget>[
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: const Text('OK'),
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     } catch (e) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Login Failed'),
//             content: Text('An error occurred.'),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: const Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   Widget _buildEmailField() {
//     return TextFormField(
//       controller: _emailController,
//       decoration: InputDecoration(
//         labelText: 'Email',
//         prefixIcon: Icon(Icons.email),
//       ),
//       keyboardType: TextInputType.emailAddress,
//       validator: (value) {
//         if (value!.isEmpty) {
//           return 'Please enter your email.';
//         }
//         return null;
//       },
//     );
//   }

//   Widget _buildPasswordField() {
//     return TextFormField(
//       controller: _passwordController,
//       decoration: InputDecoration(
//         labelText: 'Password',
//         prefixIcon: Icon(Icons.lock),
//       ),
//       obscureText: true,
//       validator: (value) {
//         if (value!.isEmpty) {
//           return 'Please enter your password.';
//         }
//         return null;
//       },
//     );
//   }

//   Widget _buildSubmitButton() {
//     return SizedBox(
//       width: double.infinity,
//       height: 45,
//       child: ElevatedButton(
//         onPressed: _isLoading ? null : _login,
//         child: _isLoading
//             ? CircularProgressIndicator()
//             : Text(
//                 'Login',
//                 style: TextStyle(color: Colors.white),
//               ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login Page'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildEmailField(),
//             SizedBox(height: 16),
//             _buildPasswordField(),
//             SizedBox(height: 16),
//             _buildSubmitButton(),
//           ],
//         ),
//       ),
//     );
//   }
// }
