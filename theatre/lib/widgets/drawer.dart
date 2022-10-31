import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theatre/pages/Actionmovies.dart';
import 'package:theatre/pages/Adventuremovies.dart';
import 'package:theatre/pages/Comedymovies.dart';
import 'package:theatre/pages/Documentries.dart';
import 'package:theatre/pages/Historymovies.dart';
import 'package:theatre/pages/Home_Page.dart';
import 'package:theatre/pages/Horrormovies.dart';
import 'package:theatre/pages/Login_page.dart';
import 'package:theatre/pages/Music.dart';
import 'package:theatre/pages/Popularmovies.dart';
import 'package:theatre/pages/Scifimovies.dart';
import 'package:theatre/pages/Thrillermovies.dart';
import 'package:theatre/pages/TopRatedmovies.dart';
import 'package:theatre/pages/Trendingmovies.dart';
import 'package:theatre/pages/Upcomingmovies.dart';
import 'package:theatre/utils/routes.dart';

import '../pages/mylist.dart';

List<bool> _likes = List.filled(1000, true);

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  signout() async {
    await FirebaseAuth.instance.signOut();

    Navigator.pushReplacement(
        this.context,
        MaterialPageRoute(
          builder: (context) => Login_Page(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromARGB(255, 13, 13, 13),
        child: ListView(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  DrawerHeader(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset(
                            'assets/images/Pranjal02.png',
                            height: 190,
                            width: 190,
                          ))),
                  ListTile(
                    title: TextButton(
                      child: Text(
                        "Home",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.2,
                        style: TextStyle(
                          color: Colors.white54,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, MyRoutes.HomeRoute);
                      },
                    ),
                  ),
                  ListTile(
                    title: TextButton(
                      child: Text(
                        "Liked Movies",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.2,
                        style: TextStyle(
                          color: Colors.white54,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MyList()));
                      },
                    ),
                  ),
                  ListTile(
                    title: TextButton(
                      child: Text(
                        "Trending",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.2,
                        style: TextStyle(
                          color: Colors.white54,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TrendingPage()));
                      },
                    ),
                  ),
                  ListTile(
                    title: TextButton(
                      child: Text(
                        "Top Rated",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.2,
                        style: TextStyle(
                          color: Colors.white54,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TopRatedPage()));
                      },
                    ),
                  ),
                  ListTile(
                    title: TextButton(
                      child: Text(
                        "Upcoming",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.2,
                        style: TextStyle(
                          color: Colors.white54,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpcomingPage()));
                      },
                    ),
                  ),
                  ListTile(
                    title: TextButton(
                      child: Text(
                        "Popular",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.2,
                        style: TextStyle(
                          color: Colors.white54,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PopularPage()));
                      },
                    ),
                  ),
                  ListTile(
                    title: TextButton(
                      child: Text(
                        "Action",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.2,
                        style: TextStyle(
                          color: Colors.white54,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ActionPage()));
                      },
                    ),
                  ),
                  ListTile(
                    title: TextButton(
                      child: Text(
                        "Adventure",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.2,
                        style: TextStyle(
                          color: Colors.white54,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdventurePage()));
                      },
                    ),
                  ),
                  ListTile(
                    title: TextButton(
                      child: Text(
                        "Horror",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.2,
                        style: TextStyle(
                          color: Colors.white54,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HorrorPage()));
                      },
                    ),
                  ),
                  ListTile(
                    title: TextButton(
                      child: Text(
                        "Comedy",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.2,
                        style: TextStyle(
                          color: Colors.white54,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ComedyPage()));
                      },
                    ),
                  ),
                  ListTile(
                    title: TextButton(
                      child: Text(
                        "History",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.2,
                        style: TextStyle(
                          color: Colors.white54,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HistoryPage()));
                      },
                    ),
                  ),
                  ListTile(
                    title: TextButton(
                      child: Text(
                        "Thriller",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.2,
                        style: TextStyle(
                          color: Colors.white54,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ThrillerPage()));
                      },
                    ),
                  ),
                  ListTile(
                    title: TextButton(
                      child: Text(
                        "Scifi",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.2,
                        style: TextStyle(
                          color: Colors.white54,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ScifiPage()));
                      },
                    ),
                  ),
                  ListTile(
                    title: TextButton(
                      child: Text(
                        "Documentries",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.2,
                        style: TextStyle(
                          color: Colors.white54,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DocumentryPage()));
                      },
                    ),
                  ),
                  ListTile(
                    title: TextButton(
                      child: Text(
                        "Music",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.2,
                        style: TextStyle(
                          color: Colors.white54,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MusicPage()));
                      },
                    ),
                  ),
                  ListTile(
                    title: TextButton(
                      child: Text(
                        "Sign Out",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.2,
                        style: TextStyle(
                          color: Colors.white54,
                        ),
                      ),
                      onPressed: () => signout(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
