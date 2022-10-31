import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:theatre/pages/Description.dart';
import 'package:theatre/widgets/Action.dart';
import 'package:theatre/widgets/appbar.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../widgets/drawer.dart';

bool isliked48 = false;

class ActionPage extends StatefulWidget {
  const ActionPage({Key? key}) : super(key: key);

  @override
  State<ActionPage> createState() => _ActionPageState();
}

class _ActionPageState extends State<ActionPage> {
  late DatabaseReference dbref;
  final String urltrending1 =
      "https://api.themoviedb.org/3/discover/movie?api_key=b3683b201570bdba7301facb6448362c&with_genres=28&page=2";
  final String urltrending2 =
      "https://api.themoviedb.org/3/discover/movie?api_key=b3683b201570bdba7301facb6448362c&with_genres=28&page=3";
  final String urltrending3 =
      "https://api.themoviedb.org/3/discover/movie?api_key=b3683b201570bdba7301facb6448362c&with_genres=28&page=4";
  final String urltrending4 =
      "https://api.themoviedb.org/3/discover/movie?api_key=b3683b201570bdba7301facb6448362c&with_genres=28&page=5";
  final String urltrending5 =
      "https://api.themoviedb.org/3/discover/movie?api_key=b3683b201570bdba7301facb6448362c&with_genres=28&page=6";
  List<ActionMovies> actionmovies1 = [];
  @override
  void initState() {
    getJsonData();
    dbref = FirebaseDatabase.instance.ref().child('Liked Videos');
    //.child(FirebaseAuth.instance.currentUser.email.toString());
    super.initState();
  }

  Future getJsonData() async {
    var responsetrending1 = await http.get(Uri.parse(urltrending1));
    var jsonDatatrending1 = jsonDecode(responsetrending1.body);
    var responsetrending2 = await http.get(Uri.parse(urltrending2));
    var jsonDatatrending2 = jsonDecode(responsetrending2.body);
    var responsetrending3 = await http.get(Uri.parse(urltrending3));
    var jsonDatatrending3 = jsonDecode(responsetrending3.body);
    var responsetrending4 = await http.get(Uri.parse(urltrending4));
    var jsonDatatrending4 = jsonDecode(responsetrending4.body);
    var responsetrending5 = await http.get(Uri.parse(urltrending5));
    var jsonDatatrending5 = jsonDecode(responsetrending5.body);
    setState(() {
      for (var i in jsonDatatrending1['results']) {
        ActionMovies action1 = ActionMovies(
            title: i["title"],
            overview: i['overview'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        actionmovies1.add(action1);
      }
      for (var i in jsonDatatrending2['results']) {
        ActionMovies action2 = ActionMovies(
            title: i["title"],
            overview: i['overview'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        actionmovies1.add(action2);
      }
      for (var i in jsonDatatrending3['results']) {
        ActionMovies action3 = ActionMovies(
            title: i["title"],
            overview: i['overview'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        actionmovies1.add(action3);
      }
      for (var i in jsonDatatrending4['results']) {
        ActionMovies action4 = ActionMovies(
            title: i["title"],
            overview: i['overview'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        actionmovies1.add(action4);
      }
      for (var i in jsonDatatrending5['results']) {
        ActionMovies action5 = ActionMovies(
            title: i["title"],
            overview: i['overview'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        actionmovies1.add(action5);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(56), child: MyAppBar()),
        body: SingleChildScrollView(
          child: Container(
            child: Column(children: [
              GridView.count(
                physics: ScrollPhysics(),
                crossAxisCount: 3,
                mainAxisSpacing: 30,
                crossAxisSpacing: 5,
                childAspectRatio: 0.5,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children:
                    new List<Widget>.generate(actionmovies1.length, (index) {
                  return Container(
                    child: Column(
                      children: [
                        Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          elevation: 5,
                          child: Image.network(
                              // ignore: prefer_interpolation_to_compose_strings
                              "https://image.tmdb.org/t/p/w500/" +
                                  actionmovies1[index].poster_path,
                              fit: BoxFit.fill),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MovieDesc(
                                                name:
                                                    actionmovies1[index].title,
                                                backdrop_path:
                                                    "https://image.tmdb.org/t/p/w500/" +
                                                        actionmovies1[index]
                                                            .backdrop_path,
                                                overview: actionmovies1[index]
                                                    .overview,
                                                released_on:
                                                    actionmovies1[index]
                                                        .release_date,
                                                vote_count: actionmovies1[index]
                                                    .vote_count,
                                                id: actionmovies1[index].id)));
                                  },
                                  icon: Icon(
                                    CupertinoIcons.info_circle,
                                    color: Colors.white,
                                  )),
                            ),
                            IconButton(
                                onPressed: () {
                                  // if (isliked48) {
                                  //           dbref.push().set(
                                  //               actionmovies1[index].poster_path);
                                  //         } else {
                                  //           //dbref.remove();
                                  //         }
                                  //         isliked48 = !isliked48;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                          content: const Text(
                                            "Feature Coming Soon",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          backgroundColor:
                                              Color.fromARGB(255, 68, 68, 68),
                                        ),
                                  );
                                },
                                icon: Icon(
                                  CupertinoIcons.add,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
