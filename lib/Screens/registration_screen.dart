import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uber_app/Screens/loginscreen.dart';
import 'package:uber_app/Screens/mainscreen.dart';
import 'package:uber_app/main.dart';

import '../Widgets/progressdialog.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const String idScreen = "register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10.0),
            const Image(
              image: AssetImage("images/logo.png"),
              width: 300.0,
              height: 250.0,
              alignment: Alignment.center,
            ),
            const Text(
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
                    textCapitalization: TextCapitalization.words,
                    controller: nameController,
                    decoration: const InputDecoration(
                        labelText: "Name",
                        labelStyle: TextStyle(fontSize: 14),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        )),
                    style: const TextStyle(fontSize: 14),
                  ),
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
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                        labelText: "Phone",
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
                      if (nameController.text.length < 4) {
                        displayToastMessage(
                            "Name must be atleast 3 characters.", context);
                      } else if (!emailController.text.contains("@")) {
                        displayToastMessage("Email address invalid", context);
                      } else if (phoneController.text.isEmpty) {
                        displayToastMessage("Phone number required", context);
                      } else if (passwordController.text.length < 6) {
                        displayToastMessage(
                            "Password must be atleast 6 characters.", context);
                      }
                      registerNewUser(context);
                    },
                    color: Colors.yellow,
                    textColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                    child: const SizedBox(
                      height: 50,
                      child: Center(
                        child: Text(
                          "Create Account",
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
                  text: "Already have an account?",
                  style: const TextStyle(
                      color: Colors.black, fontFamily: "Brand Bold"),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Login!',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 211, 194, 41),
                          fontSize: 16),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, LoginScreen.idScreen, (route) => false);
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
  registerNewUser(BuildContext context) async {
    try {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return ProgressDialog(
              message: "Registering, Please Wait...",
            );
          });
      final User? firebaseUser =
          (await _firebaseAuth.createUserWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text))
              .user;
      if (firebaseUser != null) {
        Map userDataMap = {
          "name": nameController.text.trim(),
          "email": emailController.text.trim(),
          "phone": phoneController.text.trim(),
        };
        userRef.child(firebaseUser.uid).set(userDataMap);
        if (!mounted) return;
        displayToastMessage(
            "Congratulations, your account has been succesfully created.",
            context);
        Navigator.pushNamedAndRemoveUntil(
            context, MainScreen.idScreen, (route) => false);
      } else {
        if (!mounted) return;
        Navigator.pop(context);

        displayToastMessage("User has not been created", context);
      }
    } catch (errMsg) {
      Navigator.pop(context);
      print(errMsg.toString());
      // displayToastMessage("$errMsg.toString()", context);
    }
  }
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
