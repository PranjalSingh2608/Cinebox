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
      child: Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 25, 2, 83),
        ),
        body: Scrollbar(
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: FutureBuilder(
                      future: _firebaseapp,
                      builder: ((context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              Icon(
                                CupertinoIcons.lock,
                                size: 60,
                                color: Colors.white,
                              ),
                              Text(
                                "Sign Up",
                                style: TextStyle(
                                  fontFamily: GoogleFonts.lato().fontFamily,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: email,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                          fillColor: Colors.white54,
                                          filled: true,
                                          contentPadding:
                                              EdgeInsets.fromLTRB(5, 8, 5, 0),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: new BorderSide(
                                              color: Colors.transparent,
                                              width: 1.0,
                                            ),
                                          ),
                                          labelText: "Email",
                                          labelStyle:
                                              TextStyle(color: Colors.white),
                                          hintText: "Enter your Email",
                                          hintStyle: TextStyle(
                                            color: Colors.white,
                                          )),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: password,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.fromLTRB(5, 8, 5, 8),
                                          fillColor: Colors.white54,
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: new BorderSide(
                                              color: Colors.transparent,
                                              width: 1.0,
                                            ),
                                          ),
                                          labelText: "Password",
                                          labelStyle:
                                              TextStyle(color: Colors.white),
                                          hintText: "Enter your Password",
                                          hintStyle: TextStyle(
                                            color: Colors.white,
                                          )),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton(
                                        onPressed: () async {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          await FirebaseAuth.instance
                                              .createUserWithEmailAndPassword(
                                                  email: email.text,
                                                  password: password.text);
                                          Navigator.pushNamed(
                                              context, MyRoutes.HomeRoute);
                                          setState(() {
                                            isLoading = false;
                                          });
                                        },
                                        child: const Text(
                                          "Sign Up",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18.0),
                                                    side: BorderSide(
                                                        color: Color.fromARGB(
                                                            255,
                                                            25,
                                                            2,
                                                            83)))))),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                color: Colors.white54,
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
      ),
    );
  }
}
