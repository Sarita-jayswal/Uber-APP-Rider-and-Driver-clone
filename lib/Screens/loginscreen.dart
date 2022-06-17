import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:uber_app/Screens/mainscreen.dart';
import 'package:uber_app/Screens/registration_screen.dart';
import 'package:uber_app/Widgets/progressdialog.dart';
import 'package:uber_app/main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static String idScreen = "login";
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(fontSize: 14),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        )),
                    style: const TextStyle(fontSize: 14),
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(fontSize: 14),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        )),
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  MaterialButton(
                    onPressed: () {
                      if (!emailController.text.contains("@")) {
                        displayToastMessage("Email address invalid", context);
                      } else if (passwordController.text.isEmpty) {
                        displayToastMessage("Password Required!!!", context);
                      } else {
                        loginWithEmailPassword(context);
                      }
                    },
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

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void loginWithEmailPassword(BuildContext context) async {
    try {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const ProgressDialog(
              message: "Authenticating, Please Wait...",
            );
          });
      final User? firebaseUser =
          (await _firebaseAuth.signInWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text))
              .user;
      if (firebaseUser != null) {
        userRef.child(firebaseUser.uid).once().then((event) {
          if (event.snapshot.value != null) {
            Navigator.pushNamedAndRemoveUntil(
                context, MainScreen.idScreen, (route) => false);
            displayToastMessage("Login Succesfull", context);
          } else {
            Navigator.pop(context);

            _firebaseAuth.signOut();
            displayToastMessage("Please Create New Account!!", context);
          }
        });
      } else {
        if (!mounted) return;
        Navigator.pop(context);

        displayToastMessage("Error occured", context);
      }
    } catch (errMsg) {
      Navigator.pop(context);
      // print(errMsg.toString());
      displayToastMessage("$errMsg", context);
    }
  }
}
