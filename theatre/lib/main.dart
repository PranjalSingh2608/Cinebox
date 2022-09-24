import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theatre/pages/Signup_page.dart';
import 'package:theatre/pages/description.dart';
import 'package:theatre/utils/routes.dart';
import 'pages/Home_Page.dart';
import 'pages/Login_page.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  runApp(const MyApp());
}

var idx;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      initialRoute:FirebaseAuth.instance.currentUser != null ? '/home' : '/signup',
      routes: {
        MyRoutes.SignUpRoute: ((context) => SignUp_Page()),
        MyRoutes.HomeRoute: ((context) => Home_page()),
        MyRoutes.LoginRoute: ((context) => Login_Page())
      },
    );
  }
}
