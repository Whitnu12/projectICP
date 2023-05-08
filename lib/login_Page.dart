import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> signInWithEmailAndPassword(BuildContext context) async {
    try {
      await Auth().signinWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Invalid email or password.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        setState(() {
          errorMessage = e.message;
        });
      }
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(errorMessage ?? ''),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Widget title() {
    return const Text('Login Page');
  }

  Widget _entryField(
    String title,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: title,icon: Icon(Icons.email)),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage ?? ' ');
  }

  Widget _submitButton(BuildContext context) {
    return SizedBox(
        width: 200,
        height: 45,
        child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 45, 106, 79)),
          onPressed: isLogin
              ? () => signInWithEmailAndPassword(context)
              : createUserWithEmailAndPassword,
          child: Text(
            'Login',
            // isLogin ? 'Login' : 'Register',
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          ),
        ));
  }

  // Widget _loginOrRegisterButton() {
  //   return SizedBox(
  //       width: 200,
  //       height: 45,
  //       child: TextButton(
  //         onPressed: () {
  //           setState(() {
  //             isLogin = !isLogin;
  //           });
  //         },
  //         child: Text(isLogin ? 'Register' : 'Login'),
  //       ));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 170, 255, 139)
            ])),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Login',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            _entryField('Email', _emailController),
            _entryField('Password', _passwordController),
            _errorMessage(),
            _submitButton(context),
            // _loginOrRegisterButton(),
          ],
        ),
      ),
    );
  }
}
