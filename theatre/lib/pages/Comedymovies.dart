import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:theatre/pages/Description.dart';
import 'package:theatre/widgets/Comedy.dart';
import 'package:theatre/widgets/appbar.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../widgets/drawer.dart';
bool isliked46 = false;
class ComedyPage extends StatefulWidget {
  const ComedyPage({Key? key}) : super(key: key);

  @override
  State<ComedyPage> createState() => _ComedyPageState();
}

class _ComedyPageState extends State<ComedyPage> {
  late DatabaseReference dbref;
  final String urltrending1 =
      "https://api.themoviedb.org/3/discover/movie?api_key=b3683b201570bdba7301facb6448362c&with_genres=35&page=2";
  final String urltrending2 =
      "https://api.themoviedb.org/3/discover/movie?api_key=b3683b201570bdba7301facb6448362c&with_genres=35&page=3";
  final String urltrending3 =
      "https://api.themoviedb.org/3/discover/movie?api_key=b3683b201570bdba7301facb6448362c&with_genres=35&page=4";
  final String urltrending4 =
      "https://api.themoviedb.org/3/discover/movie?api_key=b3683b201570bdba7301facb6448362c&with_genres=35&page=5";
  final String urltrending5 =
      "https://api.themoviedb.org/3/discover/movie?api_key=b3683b201570bdba7301facb6448362c&with_genres=35&page=6";
  List<ComedyMovies> comedymovies1 = [];
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
        ComedyMovies comedy1 = ComedyMovies(
            title: i["title"],
            overview: i['overview'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        comedymovies1.add(comedy1);
      }
      for (var i in jsonDatatrending2['results']) {
        ComedyMovies comedy2 = ComedyMovies(
            title: i["title"],
            overview: i['overview'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        comedymovies1.add(comedy2);
      }
      for (var i in jsonDatatrending3['results']) {
        ComedyMovies comedy3 = ComedyMovies(
            title: i["title"],
            overview: i['overview'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        comedymovies1.add(comedy3);
      }
      for (var i in jsonDatatrending4['results']) {
        ComedyMovies comedy4 = ComedyMovies(
            title: i["title"],
            overview: i['overview'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        comedymovies1.add(comedy4);
      }
      for (var i in jsonDatatrending5['results']) {
        ComedyMovies comedy5 = ComedyMovies(
            title: i["title"],
            overview: i['overview'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        comedymovies1.add(comedy5);
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
              child:Container(
                child:Column(
                  children:[
                    GridView.count(
                  physics: ScrollPhysics(),
                  crossAxisCount: 3,
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 5,
                  childAspectRatio: 0.5,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: new List<Widget>.generate(comedymovies1.length,
                      (index) {
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
                                    comedymovies1[index].poster_path,
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
                                                  name:comedymovies1[index]
                                                      .title,
                                                  backdrop_path:
                                                      "https://image.tmdb.org/t/p/w500/" +
                                                          comedymovies1[index]
                                                              .backdrop_path,
                                                  overview:
                                                      comedymovies1[index]
                                                          .overview,
                                                  released_on:
                                                      comedymovies1[index]
                                                          .release_date,
                                                  vote_count:
                                                      comedymovies1[index]
                                                          .vote_count,
                                                  id: comedymovies1[index]
                                                      .id)));
                                    },
                                    icon: Icon(
                                      CupertinoIcons.info_circle,
                                      color: Colors.white,
                                    )),
                              ),
                              IconButton(
                                  onPressed: () {
                                    if (isliked46) {
                                              dbref.push().set(
                                                 comedymovies1[index].poster_path);
                                            } else {
                                              //dbref.remove();
                                            }
                                            isliked46 = !isliked46;
                                  },
                                  icon: Icon(
                                    CupertinoIcons.heart,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                  ]
                ),
              ),
            ),
      ),

    );
  }
}
