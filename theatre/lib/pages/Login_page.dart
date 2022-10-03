import 'package:lottie/lottie.dart';
import 'package:theatre/pages/Home_Page.dart';
import 'package:theatre/utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:theatre/widgets/share.dart';
import 'Login_Page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({Key? key}) : super(key: key);

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  late Future<FirebaseApp> _firebaseapp;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _firebaseapp = Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.black,
        child: Scaffold(
          backgroundColor: Colors.black87,
          body: Scrollbar(
            child: FutureBuilder(
              future: _firebaseapp,
              builder: (context, snapshot) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 70,
                      ),
                      SizedBox(
                        height: 200,
                        width: 200,
                        child: Lottie.asset("assets/animations/welcome.json"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: email,
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(5, 8, 5, 0),
                                  prefixIcon: Icon(Icons.perm_identity,
                                      color: Color.fromARGB(255, 68, 68, 68)),
                                  fillColor: Colors.black,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: new BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                  ),
                                  labelText: "Email",
                                  labelStyle: TextStyle(color: Colors.white),
                                  hintText: "Enter your Email",
                                  hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 68, 68, 68),
                                  )),
                              validator: (String? value) {
                                if (value != null && value.isEmpty) {
                                  return "Username cannot be empty";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: password,
                              obscureText: true,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Color.fromARGB(255, 68, 68, 68),
                                  ),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(5, 8, 5, 0),
                                  fillColor: Colors.black,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: new BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                  ),
                                  labelText: "Password",
                                  labelStyle: TextStyle(color: Colors.white),
                                  hintText: "Enter your Password",
                                  hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 68, 68, 68),
                                  )),
                              validator: (String? value) {
                                if (value != null && value.isEmpty) {
                                  return "Password cannot be empty";
                                } else if (value!.length < 6) {
                                  return "Password need to be more than 6 digits";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            InkWell(
                              onTap: () async {
                                try {
                                  await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: email.text,
                                          password: password.text);
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Home_page();
                                  }));

                                  setState(() {
                                    isLoading = false;
                                  });
                                } on FirebaseAuthException catch (e) {
                                  print('failed with error code: ${e.code}');
                                  print(e.message);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor:
                                          Color.fromARGB(255, 68, 68, 68),
                                      content: const Text(
                                        'Incorrect Password Or Email',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                await Shared.getUserSharedPrefernces()
                                    .then((value) {
                                  setState(() {
                                    var isLogin = value;
                                  });
                                });
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 500),
                                width: 120,
                                height: 50,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    "Login",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 68, 68, 68),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  " Don't have an account,",
                                  style: TextStyle(
                                    color: Colors.white54,
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, MyRoutes.SignUpRoute);
                                    },
                                    child: Text(
                                      "sign up?",
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    )),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }
}
