import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:theatre/pages/Description.dart';
import 'package:theatre/widgets/appbar.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../widgets/drawer.dart';
import 'package:theatre/widgets/LikedVideos.dart';
bool isliked1 = false;
bool isliked2 = false;
bool isliked3 = false;
bool isliked4 = false;
bool isliked5 = false;

class TrendingMoviesPage {
  final dynamic name,
      overview,
      origin_country,
      poster_path,
      original_language,
      vote_count,
      release_date,
      backdrop_path,
      id;

  const TrendingMoviesPage(
      {this.name,
      this.overview,
      this.origin_country,
      this.poster_path,
      this.original_language,
      this.vote_count,
      this.release_date,
      this.backdrop_path,
      this.id});
  factory TrendingMoviesPage.fromJson(Map<String, dynamic> json) {
    return TrendingMoviesPage(
        name: json['name'],
        overview: json['overview'],
        origin_country: json['origin_country'],
        poster_path: json['poster_path'],
        original_language: json['original_language'],
        vote_count: json['vote_count'],
        release_date: json['release_date'],
        backdrop_path: json['backdrop_path'],
        id: json['id']);
  }
}

class TrendingPage extends StatefulWidget {
  const TrendingPage({Key? key}) : super(key: key);

  @override
  State<TrendingPage> createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  late DatabaseReference dbref;
  final String urltrending1 =
      "https://api.themoviedb.org/3/trending/all/day?api_key=b3683b201570bdba7301facb6448362c&page=2";
  final String urltrending2 =
      "https://api.themoviedb.org/3/trending/all/day?api_key=b3683b201570bdba7301facb6448362c&page=3";
  final String urltrending3 =
      "https://api.themoviedb.org/3/trending/all/day?api_key=b3683b201570bdba7301facb6448362c&page=4";
  final String urltrending4 =
      "https://api.themoviedb.org/3/trending/all/day?api_key=b3683b201570bdba7301facb6448362c&page=5";
  final String urltrending5 =
      "https://api.themoviedb.org/3/trending/all/day?api_key=b3683b201570bdba7301facb6448362c&page=6";
  List<TrendingMoviesPage> trendingmovies1 = [];
  List<TrendingMoviesPage> trendingmovies2 = [];
  List<TrendingMoviesPage> trendingmovies3 = [];
  List<TrendingMoviesPage> trendingmovies4 = [];
  List<TrendingMoviesPage> trendingmovies5 = [];
  bool isLoading = true;

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
        TrendingMoviesPage trend1 = TrendingMoviesPage(
            name: i["name"],
            overview: i['overview'],
            origin_country: i['origin_country'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        trendingmovies1.add(trend1);
      }
      for (var i in jsonDatatrending2['results']) {
        TrendingMoviesPage trend2 = TrendingMoviesPage(
            name: i["name"],
            overview: i['overview'],
            origin_country: i['origin_country'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        trendingmovies2.add(trend2);
      }
      for (var i in jsonDatatrending1['results']) {
        TrendingMoviesPage trend3 = TrendingMoviesPage(
            name: i["name"],
            overview: i['overview'],
            origin_country: i['origin_country'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        trendingmovies3.add(trend3);
      }
      for (var i in jsonDatatrending1['results']) {
        TrendingMoviesPage trend4 = TrendingMoviesPage(
            name: i["name"],
            overview: i['overview'],
            origin_country: i['origin_country'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        trendingmovies4.add(trend4);
      }
      for (var i in jsonDatatrending1['results']) {
        TrendingMoviesPage trend5 = TrendingMoviesPage(
            name: i["name"],
            overview: i['overview'],
            origin_country: i['origin_country'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        trendingmovies5.add(trend5);
        isLoading = true;
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
                        children: new List<Widget>.generate(
                            trendingmovies1.length, (index) {
                          return Container(
                            child: Column(
                              children: [
                                Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  elevation: 5,
                                  child: Image.network(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      "https://image.tmdb.org/t/p/w500/" +
                                          trendingmovies1[index].poster_path,
                                      fit: BoxFit.fill),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => MovieDesc(
                                                        name: trendingmovies1[
                                                                index]
                                                            .name,
                                                        backdrop_path:
                                                            "https://image.tmdb.org/t/p/w500/" +
                                                                trendingmovies1[
                                                                        index]
                                                                    .backdrop_path,
                                                        overview:
                                                            trendingmovies1[index]
                                                                .overview,
                                                        released_on:
                                                            trendingmovies1[index]
                                                                .release_date,
                                                        vote_count:
                                                            trendingmovies1[
                                                                    index]
                                                                .vote_count,
                                                        id: trendingmovies1[
                                                                index]
                                                            .id)));
                                          },
                                          icon: Icon(
                                            CupertinoIcons.info_circle,
                                            color: Colors.white,
                                          )),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          
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
                      GridView.count(
                        physics: ScrollPhysics(),
                        crossAxisCount: 3,
                        mainAxisSpacing: 30,
                        crossAxisSpacing: 5,
                        childAspectRatio: 0.5,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: new List<Widget>.generate(
                            trendingmovies2.length, (index) {
                          return Container(
                            child: Column(
                              children: [
                                Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  elevation: 5,
                                  child: Image.network(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      "https://image.tmdb.org/t/p/w500/" +
                                          trendingmovies2[index].poster_path,
                                      fit: BoxFit.fill),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => MovieDesc(
                                                        name: trendingmovies2[
                                                                index]
                                                            .name,
                                                        backdrop_path:
                                                            "https://image.tmdb.org/t/p/w500/" +
                                                                trendingmovies2[
                                                                        index]
                                                                    .backdrop_path,
                                                        overview:
                                                            trendingmovies2[index]
                                                                .overview,
                                                        released_on:
                                                            trendingmovies2[index]
                                                                .release_date,
                                                        vote_count:
                                                            trendingmovies2[
                                                                    index]
                                                                .vote_count,
                                                        id: trendingmovies2[
                                                                index]
                                                            .id)));
                                          },
                                          icon: Icon(
                                            CupertinoIcons.info_circle,
                                            color: Colors.white,
                                          )),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          
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
                      GridView.count(
                        physics: ScrollPhysics(),
                        crossAxisCount: 3,
                        mainAxisSpacing: 30,
                        crossAxisSpacing: 5,
                        childAspectRatio: 0.5,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: new List<Widget>.generate(
                            trendingmovies3.length, (index) {
                          return Container(
                            child: Column(
                              children: [
                                Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  elevation: 5,
                                  child: Image.network(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      "https://image.tmdb.org/t/p/w500/" +
                                          trendingmovies3[index].poster_path,
                                      fit: BoxFit.fill),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => MovieDesc(
                                                        name: trendingmovies3[
                                                                index]
                                                            .name,
                                                        backdrop_path:
                                                            "https://image.tmdb.org/t/p/w500/" +
                                                                trendingmovies3[
                                                                        index]
                                                                    .backdrop_path,
                                                        overview:
                                                            trendingmovies3[index]
                                                                .overview,
                                                        released_on:
                                                            trendingmovies3[index]
                                                                .release_date,
                                                        vote_count:
                                                            trendingmovies3[
                                                                    index]
                                                                .vote_count,
                                                        id: trendingmovies3[
                                                                index]
                                                            .id)));
                                          },
                                          icon: Icon(
                                            CupertinoIcons.info_circle,
                                            color: Colors.white,
                                          )),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          
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
                      GridView.count(
                        physics: ScrollPhysics(),
                        crossAxisCount: 3,
                        mainAxisSpacing: 30,
                        crossAxisSpacing: 5,
                        childAspectRatio: 0.5,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: new List<Widget>.generate(
                            trendingmovies4.length, (index) {
                          return Container(
                            child: Column(
                              children: [
                                Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  elevation: 5,
                                  child: Image.network(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      "https://image.tmdb.org/t/p/w500/" +
                                          trendingmovies4[index].poster_path,
                                      fit: BoxFit.fill),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => MovieDesc(
                                                        name: trendingmovies4[
                                                                index]
                                                            .name,
                                                        backdrop_path:
                                                            "https://image.tmdb.org/t/p/w500/" +
                                                                trendingmovies4[
                                                                        index]
                                                                    .backdrop_path,
                                                        overview:
                                                            trendingmovies4[index]
                                                                .overview,
                                                        released_on:
                                                            trendingmovies4[index]
                                                                .release_date,
                                                        vote_count:
                                                            trendingmovies4[
                                                                    index]
                                                                .vote_count,
                                                        id: trendingmovies4[
                                                                index]
                                                            .id)));
                                          },
                                          icon: Icon(
                                            CupertinoIcons.info_circle,
                                            color: Colors.white,
                                          )),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          
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
                      GridView.count(
                        physics: ScrollPhysics(),
                        crossAxisCount: 3,
                        mainAxisSpacing: 30,
                        crossAxisSpacing: 5,
                        childAspectRatio: 0.5,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: new List<Widget>.generate(
                            trendingmovies5.length, (index) {
                          return Container(
                            child: Column(
                              children: [
                                Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  elevation: 5,
                                  child: Image.network(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      "https://image.tmdb.org/t/p/w500/" +
                                          trendingmovies5[index].poster_path,
                                      fit: BoxFit.fill),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => MovieDesc(
                                                        name: trendingmovies5[
                                                                index]
                                                            .name,
                                                        backdrop_path:
                                                            "https://image.tmdb.org/t/p/w500/" +
                                                                trendingmovies5[
                                                                        index]
                                                                    .backdrop_path,
                                                        overview:
                                                            trendingmovies5[index]
                                                                .overview,
                                                        released_on:
                                                            trendingmovies5[index]
                                                                .release_date,
                                                        vote_count:
                                                            trendingmovies5[
                                                                    index]
                                                                .vote_count,
                                                        id: trendingmovies5[
                                                                index]
                                                            .id)));
                                          },
                                          icon: Icon(
                                            CupertinoIcons.info_circle,
                                            color: Colors.white,
                                          )),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          
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
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
