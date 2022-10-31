import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:theatre/pages/Home_Page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/rendering.dart';
import 'package:theatre/pages/description.dart';
import 'package:theatre/widgets/appbar.dart';
bool isliked26 = false;
class TopRatedPage extends StatefulWidget {
  const TopRatedPage({Key? key}) : super(key: key);

  @override
  State<TopRatedPage> createState() => _TopRatedPageState();
}

class _TopRatedPageState extends State<TopRatedPage> {
  late DatabaseReference dbref;
  final String urltrending1 =
      "https://api.themoviedb.org/3/movie/top_rated?api_key=b3683b201570bdba7301facb6448362c&page=2";
  final String urltrending2 =
      "https://api.themoviedb.org/3/movie/top_rated?api_key=b3683b201570bdba7301facb6448362c&page=3";
  final String urltrending3 =
      "https://api.themoviedb.org/3/movie/top_rated?api_key=b3683b201570bdba7301facb6448362c&page=4";
  final String urltrending4 =
      "https://api.themoviedb.org/3/movie/top_rated?api_key=b3683b201570bdba7301facb6448362c&page=5";
  final String urltrending5 =
      "https://api.themoviedb.org/3/movie/top_rated?api_key=b3683b201570bdba7301facb6448362c&page=6";
  List<TopRatedMovies> topratedmovies1 = [];
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
        TopRatedMovies toprated1 = TopRatedMovies(
            title: i["title"],
            overview: i['overview'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        topratedmovies1.add(toprated1);
      }
      for (var i in jsonDatatrending2['results']) {
        TopRatedMovies toprated2 = TopRatedMovies(
            title: i["title"],
            overview: i['overview'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        topratedmovies1.add(toprated2);
      }
      for (var i in jsonDatatrending3['results']) {
        TopRatedMovies toprated3 = TopRatedMovies(
            title: i["title"],
            overview: i['overview'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        topratedmovies1.add(toprated3);
      }
      for (var i in jsonDatatrending4['results']) {
        TopRatedMovies toprated4 = TopRatedMovies(
            title: i["title"],
            overview: i['overview'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        topratedmovies1.add(toprated4);
      }
      for (var i in jsonDatatrending5['results']) {
        TopRatedMovies toprated5 = TopRatedMovies(
            title: i["title"],
            overview: i['overview'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        topratedmovies1.add(toprated5);
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
            child: Column(
              children: [
                GridView.count(
                  physics: ScrollPhysics(),
                  crossAxisCount: 3,
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 5,
                  childAspectRatio: 0.5,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: new List<Widget>.generate(topratedmovies1.length,
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
                                    topratedmovies1[index].poster_path,
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
                                                  name: topratedmovies1[index]
                                                      .title,
                                                  backdrop_path:
                                                      "https://image.tmdb.org/t/p/w500/" +
                                                          topratedmovies1[index]
                                                              .backdrop_path,
                                                  overview:
                                                      topratedmovies1[index]
                                                          .overview,
                                                  released_on:
                                                      topratedmovies1[index]
                                                          .release_date,
                                                  vote_count:
                                                      topratedmovies1[index]
                                                          .vote_count,
                                                  id: topratedmovies1[index]
                                                      .id)));
                                    },
                                    icon: Icon(
                                      CupertinoIcons.info_circle,
                                      color: Colors.white,
                                    )),
                              ),
                              IconButton(
                                  onPressed: () {
                                    // if (isliked26) {
                                    //           dbref.push().set(
                                    //               topratedmovies1[index].poster_path);
                                    //         } else {
                                    //           //dbref.remove();
                                    //         }
                                    //         isliked26 = !isliked26;
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
