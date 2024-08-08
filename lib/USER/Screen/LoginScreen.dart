import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/ADMIN/utama/home.dart';
import 'package:myapp/USER/all%20page/homePage.dart';
import 'package:myapp/USER/Screen/CreateScreen.dart'; // Import halaman Sign Up
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen();

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future _login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
//-----popup-------------------
      showDialog<void>(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text("Pemberitahuan !!!"),
            content: Text("Akun data tidak benar!"),
            actions: <Widget>[
              TextButton(
                child: Text("Tutup"),
                onPressed: () {
                  Navigator.of(dialogContext)
                      .pop(); // Menutup dialog saat tombol ditekan
                },
              ),
            ],
          );
        },
      );
//-----popup-------------------

      return;
      // Optional, tergantung pada logika Anda
    } else {
      final Response = await http
          .post(Uri.parse("https://mobileapp.my.id/API/index.php"), body: {
        "username": _emailController.text,
        "password": _passwordController.text,
        "action": "login"
      });
      

      var datauser = jsonDecode(Response.body);

      if (datauser == '1') {
        showDialog<void>(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: Text("Pemberitahuan !!!"),
              content: Text("Akun anda tidak terdaftar!"),
              actions: <Widget>[
                TextButton(
                  child: Text("Tutup"),
                  onPressed: () {
                    Navigator.of(dialogContext)
                        .pop(); // Menutup dialog saat tombol ditekan
                  },
                ),
              ],
            );
          },
        );
      } else {
        var user_id = datauser[0]['id_user'];
        var roll = datauser[0]['roll'];

        if (roll == 'admin') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => HomeAdm(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => MyHomePage(),
            ),
          );
        }

        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // // prefs.setBool("isUser", true);
        // prefs.setString("usr_id", datauser[0]['id_user']);

        return datauser;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(243, 162, 11, 1),
                Color.fromARGB(255, 19, 16, 21),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.only(top: 60.0, left: 22),
            child: Text(
              'Hello\nSign In !',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 200.0),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              color: Colors.white,
            ),
            height: double.infinity,
            width: double.infinity,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            label: Text(
                          'Gmail',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(182, 179, 90, 17),
                          ),
                        )),
                      ),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                            label: Text(
                          'Password',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(182, 179, 90, 17),
                          ),
                        )),
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(height: 70),
                      GestureDetector(
                        onTap: () {
                          _login();
                        },
                        child: Container(
                          height: 55,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(colors: [
                              Color.fromRGBO(243, 162, 11, 1),
                              Color.fromARGB(255, 19, 16, 21),
                            ]),
                          ),
                          child: const Center(
                            child: Text(
                              'SIGN IN',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Createscreen()));
                              },
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
