import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theatre/pages/Signup_page.dart';
import 'package:theatre/pages/description.dart';
import 'package:theatre/utils/routes.dart';
import 'package:theatre/widgets/share.dart';
import 'pages/Home_Page.dart';
import 'pages/Login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  runApp(const MyApp());
}

var idx;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  var isLogin;

  checkUserLoginState() async {
    await Shared.getUserSharedPrefernces().then(
      (value) {
        setState(() {
          isLogin = value;
        });
      },
    );
  }

  void iniState() {
    checkUserLoginState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.grey,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
              ),
        ),
      ),
      initialRoute:
          FirebaseAuth.instance.currentUser != null ? '/home' : '/login',
      routes: {
        MyRoutes.SignUpRoute: ((context) => SignUp_Page()),
        MyRoutes.HomeRoute: ((context) => Home_page()),
        MyRoutes.LoginRoute: ((context) => Login_Page())
      },
    );
  }
}
