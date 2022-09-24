import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:theatre/pages/Description.dart';
import 'package:theatre/widgets/LikedVideos.dart';
import 'package:theatre/widgets/appbar.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../widgets/drawer.dart';


class UpcomingMoviesPage {
  final dynamic title,
      overview,
      origin_country,
      poster_path,
      original_language,
      vote_count,
      release_date,
      backdrop_path,
      id;

  const UpcomingMoviesPage(
      {this.title,
      this.overview,
      this.origin_country,
      this.poster_path,
      this.original_language,
      this.vote_count,
      this.release_date,
      this.backdrop_path,
      this.id});
  factory UpcomingMoviesPage.fromJson(Map<String, dynamic> json) {
    return UpcomingMoviesPage(
        title: json['title'],
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

class UpcomingPage extends StatefulWidget {
  const UpcomingPage({Key? key}) : super(key: key);

  @override
  State<UpcomingPage> createState() => _UpcomingPageState();
}

class _UpcomingPageState extends State<UpcomingPage> {
  final String urltrending1 =
      "https://api.themoviedb.org/3/movie/upcoming?api_key=b3683b201570bdba7301facb6448362c&page=2";
  final String urltrending2 =
      "https://api.themoviedb.org/3/movie/upcoming?api_key=b3683b201570bdba7301facb6448362c&page=3";
  final String urltrending3 =
      "https://api.themoviedb.org/3/movie/upcoming?api_key=b3683b201570bdba7301facb6448362c&page=4";
  final String urltrending4 =
      "https://api.themoviedb.org/3/movie/upcoming?api_key=b3683b201570bdba7301facb6448362c&page=5";
  final String urltrending5 =
      "https://api.themoviedb.org/3/movie/upcoming?api_key=b3683b201570bdba7301facb6448362c&page=6";
  List<UpcomingMoviesPage> upcomingmovies1 = [];
  List<UpcomingMoviesPage> upcomingmovies2 = [];
  List<UpcomingMoviesPage> upcomingmovies3 = [];
  List<UpcomingMoviesPage> upcomingmovies4 = [];
  List<UpcomingMoviesPage> upcomingmovies5 = [];
  var isLoading = false;

  @override
  void initState() {
    getJsonData();
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
        UpcomingMoviesPage upcoming1 = UpcomingMoviesPage(
            title: i["name"],
            overview: i['overview'],
            origin_country: i['origin_country'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        upcomingmovies1.add(upcoming1);
      }
      for (var i in jsonDatatrending2['results']) {
        UpcomingMoviesPage upcoming2 = UpcomingMoviesPage(
            title: i["name"],
            overview: i['overview'],
            origin_country: i['origin_country'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        upcomingmovies2.add(upcoming2);
      }
      for (var i in jsonDatatrending1['results']) {
        UpcomingMoviesPage upcoming3 = UpcomingMoviesPage(
            title: i["name"],
            overview: i['overview'],
            origin_country: i['origin_country'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        upcomingmovies3.add(upcoming3);
      }
      for (var i in jsonDatatrending1['results']) {
        UpcomingMoviesPage upcoming4 = UpcomingMoviesPage(
            title: i["name"],
            overview: i['overview'],
            origin_country: i['origin_country'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        upcomingmovies4.add(upcoming4);
      }
      for (var i in jsonDatatrending1['results']) {
        UpcomingMoviesPage upcoming5 = UpcomingMoviesPage(
            title: i["name"],
            overview: i['overview'],
            origin_country: i['origin_country'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        upcomingmovies5.add(upcoming5);
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
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
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
                            upcomingmovies1.length, (index) {
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
                                          upcomingmovies1[index].poster_path,
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
                                                        name: upcomingmovies1[
                                                                index]
                                                            .title,
                                                        backdrop_path:
                                                            "https://image.tmdb.org/t/p/w500/" +
                                                                upcomingmovies1[
                                                                        index]
                                                                    .backdrop_path,
                                                        overview:
                                                            upcomingmovies1[index]
                                                                .overview,
                                                        released_on:
                                                            upcomingmovies1[index]
                                                                .release_date,
                                                        vote_count:
                                                            upcomingmovies1[
                                                                    index]
                                                                .vote_count,
                                                        id: upcomingmovies1[
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
                                          CupertinoIcons.heart_circle,
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
                            upcomingmovies2.length, (index) {
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
                                          upcomingmovies2[index].poster_path,
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
                                                        name: upcomingmovies2[
                                                                index]
                                                            .title,
                                                        backdrop_path:
                                                            "https://image.tmdb.org/t/p/w500/" +
                                                                upcomingmovies2[
                                                                        index]
                                                                    .backdrop_path,
                                                        overview:
                                                            upcomingmovies2[index]
                                                                .overview,
                                                        released_on:
                                                            upcomingmovies2[index]
                                                                .release_date,
                                                        vote_count:
                                                            upcomingmovies2[
                                                                    index]
                                                                .vote_count,
                                                        id: upcomingmovies2[
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
                                          CupertinoIcons.heart_circle,
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
                            upcomingmovies3.length, (index) {
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
                                          upcomingmovies3[index].poster_path,
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
                                                        name: upcomingmovies3[
                                                                index]
                                                            .title,
                                                        backdrop_path:
                                                            "https://image.tmdb.org/t/p/w500/" +
                                                                upcomingmovies3[
                                                                        index]
                                                                    .backdrop_path,
                                                        overview:
                                                            upcomingmovies3[index]
                                                                .overview,
                                                        released_on:
                                                            upcomingmovies3[index]
                                                                .release_date,
                                                        vote_count:
                                                            upcomingmovies3[
                                                                    index]
                                                                .vote_count,
                                                        id: upcomingmovies3[
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
                                          CupertinoIcons.heart_circle,
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
                            upcomingmovies4.length, (index) {
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
                                          upcomingmovies4[index].poster_path,
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
                                                        name: upcomingmovies4[
                                                                index]
                                                            .title,
                                                        backdrop_path:
                                                            "https://image.tmdb.org/t/p/w500/" +
                                                                upcomingmovies4[
                                                                        index]
                                                                    .backdrop_path,
                                                        overview:
                                                            upcomingmovies4[index]
                                                                .overview,
                                                        released_on:
                                                            upcomingmovies4[index]
                                                                .release_date,
                                                        vote_count:
                                                            upcomingmovies4[
                                                                    index]
                                                                .vote_count,
                                                        id: upcomingmovies4[
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
                                          CupertinoIcons.heart_circle,
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
                            upcomingmovies5.length, (index) {
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
                                          upcomingmovies5[index].poster_path,
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
                                                        name: upcomingmovies5[
                                                                index]
                                                            .title,
                                                        backdrop_path:
                                                            "https://image.tmdb.org/t/p/w500/" +
                                                                upcomingmovies5[
                                                                        index]
                                                                    .backdrop_path,
                                                        overview:
                                                            upcomingmovies5[index]
                                                                .overview,
                                                        released_on:
                                                            upcomingmovies5[index]
                                                                .release_date,
                                                        vote_count:
                                                            upcomingmovies5[
                                                                    index]
                                                                .vote_count,
                                                        id: upcomingmovies5[
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
                                          CupertinoIcons.heart_circle,
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
