import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:uber_app/Screens/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static String idScreen = "login";
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            const Image(
              image: AssetImage("images/logo.png"),
              width: 350.0,
              height: 300.0,
              alignment: Alignment.center,
            ),
            const Text(
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
                  const TextField(
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
                  const TextField(
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
                  const SizedBox(height: 10),
                  MaterialButton(
                    onPressed: () {},
                    color: Colors.yellow,
                    textColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                    child: const SizedBox(
                      height: 50,
                      child: Center(
                        child: Text(
                          "Login",
                          style:
                              TextStyle(fontSize: 18, fontFamily: "Brand Bold"),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                  text: "Don't have an account?",
                  style: const TextStyle(
                      color: Colors.black, fontFamily: "Brand Bold"),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Register now!',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 211, 194, 41),
                          fontSize: 16),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamedAndRemoveUntil(context,
                              RegisterScreen.idScreen, (route) => false);
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
