import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10.0),
            Image(
              image: AssetImage("images/logo.png"),
              width: 300.0,
              height: 250.0,
              alignment: Alignment.center,
            ),
            Text(
              "Register as a Rider",
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Brand Bold",
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                        labelText: "Name",
                        labelStyle: TextStyle(fontSize: 14),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        )),
                    style: TextStyle(fontSize: 14),
                  ),
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
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        labelText: "Phone",
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
                    textColor: Colors.black,
                    child: Container(
                      height: 50,
                      child: Center(
                        child: Text(
                          "Create Account",
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
            ),
            RichText(
              text: TextSpan(
                  text: "Already have an account?",
                  style:
                      TextStyle(color: Colors.black, fontFamily: "Brand Bold"),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Login!',
                      style: TextStyle(
                          color: Color.fromARGB(255, 211, 194, 41),
                          fontSize: 16),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print("rEGISTERED");
                        },
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
