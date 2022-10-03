import 'package:firebase_auth/firebase_auth.dart';
import 'package:theatre/utils/routes.dart';
import 'package:theatre/firebase_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Login_Page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignUp_Page extends StatefulWidget {
  const SignUp_Page({Key? key}) : super(key: key);

  @override
  State<SignUp_Page> createState() => _SignUp_PageState();
}

class _SignUp_PageState extends State<SignUp_Page> {
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
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 70,
                      ),
                      ClipRRect(
                        child: Image.asset("assets/images/Pranjal01.png"),
                      ),
                      Text(
                        "Sign Up",
                        style: TextStyle(
                          fontFamily: GoogleFonts.lato().fontFamily,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: email,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.perm_identity,
                                      color: Color.fromARGB(255, 68, 68, 68)),
                                  fillColor: Colors.black,
                                  filled: true,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(5, 8, 5, 0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: new BorderSide(
                                      color: Color.fromARGB(255, 68, 68, 68),
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
                                  prefixIcon: Icon(Icons.lock,
                                      color: Color.fromARGB(255, 68, 68, 68)),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(5, 8, 5, 8),
                                  fillColor: Colors.black,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: new BorderSide(
                                      color: Color.fromARGB(255, 68, 68, 68),
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
                                      .createUserWithEmailAndPassword(
                                          email: email.text,
                                          password: password.text);
                                  Navigator.pushNamed(
                                      context, MyRoutes.HomeRoute);
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
                                          )),
                                    ),
                                  );
                                }
                              },
                              child: AnimatedContainer(
                                width: 120,
                                height: 50,
                                duration: Duration(milliseconds: 500),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: const Text(
                                    "Sign Up",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 177, 177, 177),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
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
                                  "Already have an account,",
                                  style: TextStyle(
                                    color: Colors.white54,
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, MyRoutes.LoginRoute);
                                    },
                                    child: Text(
                                      "Login?",
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
              })),
        ),
      ),
    );
  }
}
