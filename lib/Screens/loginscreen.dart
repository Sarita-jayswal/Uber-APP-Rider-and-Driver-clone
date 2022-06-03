import 'dart:ui';

import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 20.0),
          Image(
            image: AssetImage("images/logo.png"),
            width: 350.0,
            height: 300.0,
            alignment: Alignment.center,
          ),
          Text(
            "Login as a Rider",
            style: TextStyle(
              fontSize: 24,
              fontFamily: "Brand Bold",
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(fontSize: 14),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      )),
                  style: TextStyle(fontSize: 14),
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(fontSize: 14),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      )),
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 10),
                MaterialButton(
                  onPressed: () {},
                  color: Colors.yellow,
                  textColor: Colors.white,
                  child: Container(
                    height: 50,
                    child: Center(
                      child: Text(
                        "Login",
                        style:
                            TextStyle(fontSize: 18, fontFamily: "Brand Bold"),
                      ),
                    ),
                  ),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(24)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
