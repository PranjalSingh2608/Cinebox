import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:theatre/pages/Description.dart';
import 'package:theatre/pages/Home_Page.dart';
import 'package:theatre/widgets/appbar.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../widgets/drawer.dart';

bool isliked41 = false;

class PopularPage extends StatefulWidget {
  const PopularPage({Key? key}) : super(key: key);

  @override
  State<PopularPage> createState() => _PopularPageState();
}

class _PopularPageState extends State<PopularPage> {
  late DatabaseReference dbref;
  final String urlpopular1 =
      'https://api.themoviedb.org/3/movie/popular?api_key=b3683b201570bdba7301facb6448362c&page=2';
  final String urlpopular2 =
      'https://api.themoviedb.org/3/movie/popular?api_key=b3683b201570bdba7301facb6448362c&page=3';
  final String urlpopular3 =
      'https://api.themoviedb.org/3/movie/popular?api_key=b3683b201570bdba7301facb6448362c&page=4';
  final String urlpopular4 =
      'https://api.themoviedb.org/3/movie/popular?api_key=b3683b201570bdba7301facb6448362c&page=5';
  final String urlpopular5 =
      'https://api.themoviedb.org/3/movie/popular?api_key=b3683b201570bdba7301facb6448362c&page=6';
  List<PopularMovies> popularmovies1 = [];
   @override
  void initState() {
    getJsonData();
    dbref = FirebaseDatabase.instance.ref().child('Liked Videos');
    //.child(FirebaseAuth.instance.currentUser.email.toString());
    super.initState();
  }
  Future getJsonData() async {
    var responsetrending1 = await http.get(Uri.parse(urlpopular1));
    var jsonDatatrending1 = jsonDecode(responsetrending1.body);
    var responsetrending2 = await http.get(Uri.parse(urlpopular2));
    var jsonDatatrending2 = jsonDecode(responsetrending2.body);
    var responsetrending3 = await http.get(Uri.parse(urlpopular3));
    var jsonDatatrending3 = jsonDecode(responsetrending3.body);
    var responsetrending4 = await http.get(Uri.parse(urlpopular4));
    var jsonDatatrending4 = jsonDecode(responsetrending4.body);
    var responsetrending5 = await http.get(Uri.parse(urlpopular5));
    var jsonDatatrending5 = jsonDecode(responsetrending5.body);
    setState(() {
      for (var i in jsonDatatrending1['results']) {
        PopularMovies popular1 = PopularMovies(
            title: i["title"],
            overview: i['overview'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        popularmovies1.add(popular1);
      }
      for (var i in jsonDatatrending1['results']) {
        PopularMovies popular2 = PopularMovies(
            title: i["title"],
            overview: i['overview'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        popularmovies1.add(popular2);
      }
      for (var i in jsonDatatrending1['results']) {
        PopularMovies popular3 = PopularMovies(
            title: i["title"],
            overview: i['overview'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        popularmovies1.add(popular3);
      }
      for (var i in jsonDatatrending1['results']) {
        PopularMovies popular4 = PopularMovies(
            title: i["title"],
            overview: i['overview'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        popularmovies1.add(popular4);
      }
      for (var i in jsonDatatrending1['results']) {
        PopularMovies popular5 = PopularMovies(
            title: i["title"],
            overview: i['overview'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        popularmovies1.add(popular5);
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
                  children: new List<Widget>.generate(popularmovies1.length,
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
                                    popularmovies1[index].poster_path,
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
                                                  name:popularmovies1[index]
                                                      .title,
                                                  backdrop_path:
                                                      "https://image.tmdb.org/t/p/w500/" +
                                                          popularmovies1[index]
                                                              .backdrop_path,
                                                  overview:
                                                      popularmovies1[index]
                                                          .overview,
                                                  released_on:
                                                      popularmovies1[index]
                                                          .release_date,
                                                  vote_count:
                                                      popularmovies1[index]
                                                          .vote_count,
                                                  id: popularmovies1[index]
                                                      .id)));
                                    },
                                    icon: Icon(
                                      CupertinoIcons.info_circle,
                                      color: Colors.white,
                                    )),
                              ),
                              IconButton(
                                  onPressed: () {
                                    if (isliked41) {
                                              dbref.push().set(
                                                  popularmovies1[index].poster_path);
                                            } else {
                                              //dbref.remove();
                                            }
                                            isliked41 = !isliked41;
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
