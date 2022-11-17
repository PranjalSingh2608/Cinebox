import 'dart:convert';
import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:theatre/pages/Signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:theatre/pages/Description.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:theatre/utils/routes.dart';
import 'package:theatre/widgets/Action.dart';
import 'package:theatre/widgets/Adventure.dart';
import 'package:theatre/widgets/Comedy.dart';
import 'package:theatre/widgets/Doc.dart';
import 'package:theatre/widgets/History.dart';
import 'package:theatre/widgets/Horror.dart';
import 'package:theatre/widgets/Music.dart';
import 'package:theatre/widgets/Scifi.dart';
import 'package:theatre/widgets/Thriller.dart';
import 'package:theatre/widgets/appbar.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../widgets/drawer.dart';
bool isliked1 = false;
bool isliked2 = false;
bool isliked3 = false;
bool isliked4 = false;
bool isliked5 = false;
bool isliked6 = false;
bool isliked7 = false;
bool isliked8 = false;
bool isliked9 = false;
bool isliked10 = false;
bool isliked11 = false;
bool isliked12 = false;
bool isliked13 = false;
bool isliked14 = false;

class TrendingMovies {
  final dynamic name,
      overview,
      origin_country,
      poster_path,
      original_language,
      vote_count,
      release_date,
      backdrop_path,
      id;

  const TrendingMovies(
      {this.name,
      this.overview,
      this.origin_country,
      this.poster_path,
      this.original_language,
      this.vote_count,
      this.release_date,
      this.backdrop_path,
      this.id});
  factory TrendingMovies.fromJson(Map<String, dynamic> json) {
    return TrendingMovies(
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

class TopRatedMovies {
  final dynamic title,
      overview,
      poster_path,
      original_language,
      vote_count,
      release_date,
      backdrop_path,
      id;

  TopRatedMovies(
      {this.title,
      this.overview,
      this.poster_path,
      this.original_language,
      this.vote_count,
      this.release_date,
      this.backdrop_path,
      this.id});
  factory TopRatedMovies.fromJson(Map<String, dynamic> json) {
    return TopRatedMovies(
        title: json['title'],
        overview: json['overview'],
        poster_path: json['poster_path'],
        original_language: json['original_language'],
        vote_count: json['vote_count'],
        release_date: json['release_date'],
        backdrop_path: json['backdrop_path'],
        id: json['id']);
  }
}

class UpcomingMovies {
  final dynamic title,
      overview,
      poster_path,
      original_language,
      vote_count,
      release_date,
      backdrop_path,
      id;

  UpcomingMovies(
      {this.title,
      this.overview,
      this.poster_path,
      this.original_language,
      this.vote_count,
      this.release_date,
      this.backdrop_path,
      this.id});
  factory UpcomingMovies.fromJson(Map<String, dynamic> json) {
    return UpcomingMovies(
        title: json['title'],
        overview: json['overview'],
        poster_path: json['poster_path'],
        original_language: json['original_language'],
        vote_count: json['vote_count'],
        release_date: json['release_date'],
        backdrop_path: json['backdrop_path'],
        id: json['id']);
  }
}

class PopularMovies {
  final dynamic title,
      overview,
      poster_path,
      original_language,
      vote_count,
      release_date,
      backdrop_path,
      id;

  PopularMovies(
      {this.title,
      this.overview,
      this.poster_path,
      this.original_language,
      this.vote_count,
      this.release_date,
      this.backdrop_path,
      this.id});
  factory PopularMovies.fromJson(Map<String, dynamic> json) {
    return PopularMovies(
        title: json['title'],
        overview: json['overview'],
        poster_path: json['poster_path'],
        original_language: json['original_language'],
        vote_count: json['vote_count'],
        release_date: json['release_date'],
        backdrop_path: json['backdrop_path'],
        id: json['id']);
  }
}

FirebaseDatabase database = FirebaseDatabase.instance;
DatabaseReference dbref = FirebaseDatabase.instance.ref();

class Home_page extends StatefulWidget {
  Home_page({Key? key}) : super(key: key);

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  DatabaseReference dbref = FirebaseDatabase.instance
      .ref()
      .child('Liked Videos')
      .child(FirebaseAuth.instance.currentUser!.uid);
  //=====================================================================================================================================//
  final String urltrending =
      "https://api.themoviedb.org/3/trending/all/day?api_key=b3683b201570bdba7301facb6448362c";
  final String urltoprated =
      "https://api.themoviedb.org/3/movie/top_rated?api_key=b3683b201570bdba7301facb6448362c";
  final String urlupcoming =
      'https://api.themoviedb.org/3/movie/upcoming?api_key=b3683b201570bdba7301facb6448362c';
  final String urlpopular =
      'https://api.themoviedb.org/3/movie/popular?api_key=b3683b201570bdba7301facb6448362c';
  final urlaction =
      'https://api.themoviedb.org/3/discover/movie?api_key=b3683b201570bdba7301facb6448362c&with_genres=28';
  final urlcomedy =
      'https://api.themoviedb.org/3/discover/movie?api_key=b3683b201570bdba7301facb6448362c&with_genres=35';
  final urlthriller =
      'https://api.themoviedb.org/3/discover/movie?api_key=b3683b201570bdba7301facb6448362c&with_genres=53';
  final urlscifi =
      'https://api.themoviedb.org/3/discover/movie?api_key=b3683b201570bdba7301facb6448362c&with_genres=878';
  final urlhorror =
      'https://api.themoviedb.org/3/discover/movie?api_key=b3683b201570bdba7301facb6448362c&with_genres=27';
  final urlhistory =
      'https://api.themoviedb.org/3/discover/movie?api_key=b3683b201570bdba7301facb6448362c&with_genres=36';
  final urldoc =
      'https://api.themoviedb.org/3/discover/movie?api_key=b3683b201570bdba7301facb6448362c&with_genres=99';
  final urlmusic =
      'https://api.themoviedb.org/3/discover/movie?api_key=b3683b201570bdba7301facb6448362c&with_genres=10402';
  final urladventure =
      'https://api.themoviedb.org/3/discover/movie?api_key=b3683b201570bdba7301facb6448362c&with_genres=12';
  List<TrendingMovies> trendingMovies = [];
  List<TopRatedMovies> topRatedMovies = [];
  List<UpcomingMovies> upcomingmovies = [];
  List<PopularMovies> popularmovies = [];
  List<ActionMovies> actionmovies = [];
  List<AdventureMovies> adventuremovies = [];
  List<ComedyMovies> comedymovies = [];
  List<ThrillerMovies> thrillermovies = [];
  List<ScifiMovies> scifimovies = [];
  List<HorrorMovies> horrormovies = [];
  List<HistoryMovies> historymovies = [];
  List<Documentries> documentry = [];
  List<Music> music = [];
  bool isLoading = false;
  @override
  void initState() {
    getJsonData();
    dbref = FirebaseDatabase.instance
        .ref()
        .child('Liked Videos')
        .child(FirebaseAuth.instance.currentUser!.uid);
    super.initState();
  }

  Future getJsonData() async {
    var responsetrending = await http.get(Uri.parse(urltrending));
    var responsetoprated = await http.get(Uri.parse(urltoprated));
    var responseupcoming = await http.get(Uri.parse(urlupcoming));
    var responsepopular = await http.get(Uri.parse(urlpopular));
    var responseaction = await http.get(Uri.parse(urlaction));
    var responseadventure = await http.get(Uri.parse(urladventure));
    var responsecomedy = await http.get(Uri.parse(urlcomedy));
    var responsethriller = await http.get(Uri.parse(urlthriller));
    var responsescifi = await http.get(Uri.parse(urlscifi));
    var responsehorror = await http.get(Uri.parse(urlhistory));
    var responsehistory = await http.get(Uri.parse(urlhorror));
    var responsedocumentry = await http.get(Uri.parse(urldoc));
    var responsemusic = await http.get(Uri.parse(urlmusic));
    var jsonDatatrending = jsonDecode(responsetrending.body);
    var jsonDatascifi = jsonDecode(responsescifi.body);
    var jsonDatatoprated = jsonDecode(responsetoprated.body);
    var jsonDataupcoming = jsonDecode(responseupcoming.body);
    var jsonDatapopular = jsonDecode(responsepopular.body);
    var jsonDataaction = jsonDecode(responseaction.body);
    var jsonDataadventure = jsonDecode(responseadventure.body);
    var jsonDatacomedy = jsonDecode(responsecomedy.body);
    var jsonDatathriller = jsonDecode(responsethriller.body);
    var jsonDatahorror = jsonDecode(responsehorror.body);
    var jsonDatahistory = jsonDecode(responsehistory.body);
    var jsonDatadocumentry = jsonDecode(responsedocumentry.body);
    var jsonDatamusic = jsonDecode(responsemusic.body);
    setState(() {
      for (var i in jsonDatatrending['results']) {
        TrendingMovies trend = TrendingMovies(
            name: i["name"],
            overview: i['overview'],
            origin_country: i['origin_country'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        trendingMovies.add(trend);
      }
      for (var i in jsonDatatoprated['results']) {
        TopRatedMovies top = TopRatedMovies(
            title: i["title"],
            overview: i['overview'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        topRatedMovies.add(top);
      }
      for (var i in jsonDataupcoming['results']) {
        UpcomingMovies upcoming = UpcomingMovies(
            title: i["title"],
            overview: i['overview'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        upcomingmovies.add(upcoming);
      }
      for (var i in jsonDatapopular['results']) {
        PopularMovies popular = PopularMovies(
            title: i["title"],
            overview: i['overview'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        popularmovies.add(popular);
      }
      for (var i in jsonDataaction['results']) {
        ActionMovies action = ActionMovies(
            title: i["title"],
            overview: i['overview'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        actionmovies.add(action);
      }
      for (var i in jsonDatatoprated['results']) {
        AdventureMovies adventure = AdventureMovies(
            title: i["title"],
            overview: i['overview'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        adventuremovies.add(adventure);
      }
      for (var i in jsonDatacomedy['results']) {
        ComedyMovies comedy = ComedyMovies(
            title: i["title"],
            overview: i['overview'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        comedymovies.add(comedy);
      }
      for (var i in jsonDatathriller['results']) {
        ThrillerMovies thrill = ThrillerMovies(
            title: i["title"],
            overview: i['overview'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        thrillermovies.add(thrill);
      }
      for (var i in jsonDatascifi['results']) {
        ScifiMovies scifi = ScifiMovies(
            title: i["title"],
            overview: i['overview'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        scifimovies.add(scifi);
      }
      for (var i in jsonDatahorror['results']) {
        HorrorMovies horror = HorrorMovies(
            title: i["title"],
            overview: i['overview'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        horrormovies.add(horror);
      }
      for (var i in jsonDatahistory['results']) {
        HistoryMovies history = HistoryMovies(
            title: i["title"],
            overview: i['overview'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        historymovies.add(history);
      }
      for (var i in jsonDatadocumentry['results']) {
        Documentries docs = Documentries(
            title: i["title"],
            overview: i['overview'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        documentry.add(docs);
      }
      for (var i in jsonDatamusic['results']) {
        Music song = Music(
            title: i["title"],
            overview: i['overview'],
            poster_path: i['poster_path'],
            original_language: i['original_language'],
            vote_count: i['vote_count'],
            release_date: i['release_date'],
            backdrop_path: i['backdrop_path'],
            id: i['id']);
        music.add(song);
      }
      isLoading = false;
    });
  }

//========================================================================================================================================//
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        drawer: MyDrawer(),
        backgroundColor: Colors.black,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(56), child: MyAppBar()),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: const Text(
                    "Trending Now",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 260,
                  child: ListView.builder(
                    itemCount: trendingMovies.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MovieDesc(
                                      name: trendingMovies[index].name,
                                      backdrop_path:
                                          "https://image.tmdb.org/t/p/w500/" +
                                              trendingMovies[index]
                                                  .backdrop_path,
                                      overview: trendingMovies[index].overview,
                                      released_on:
                                          trendingMovies[index].release_date,
                                      vote_count:
                                          trendingMovies[index].vote_count,
                                      id: trendingMovies[index].id)));
                        },
                        child: Container(
                          width: 140,
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
                                        trendingMovies[index].poster_path,
                                    fit: BoxFit.fill),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => MovieDesc(
                                                      name: trendingMovies[
                                                              index]
                                                          .name,
                                                      backdrop_path:
                                                          "https://image.tmdb.org/t/p/w500/" +
                                                              trendingMovies[
                                                                      index]
                                                                  .backdrop_path,
                                                      overview: trendingMovies[
                                                              index]
                                                          .overview,
                                                      released_on:
                                                          trendingMovies[index]
                                                              .release_date,
                                                      vote_count:
                                                          trendingMovies[index]
                                                              .vote_count,
                                                      id: trendingMovies[index]
                                                          .id)));
                                        },
                                        icon: Icon(
                                          CupertinoIcons.info,
                                          color: Colors.white,
                                        )),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      CupertinoIcons.add,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                        if (isliked1) {
                                          dbref.push().set(
                                              {'video':trendingMovies[index].poster_path});
                                        } 
                                        isliked1 = !isliked1;
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: const Text(
                    "Top Rated",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 260,
                  child: ListView.builder(
                    itemCount: topRatedMovies.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MovieDesc(
                                      name: topRatedMovies[index].title,
                                      backdrop_path:
                                          "https://image.tmdb.org/t/p/w500/" +
                                              topRatedMovies[index]
                                                  .backdrop_path,
                                      overview: topRatedMovies[index].overview,
                                      released_on:
                                          topRatedMovies[index].release_date,
                                      vote_count:
                                          topRatedMovies[index].vote_count,
                                      id: topRatedMovies[index].id)));
                        },
                        child: Container(
                          width: 140,
                          child: Column(
                            children: [
                              Card(
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                elevation: 5,
                                child: Image.network(
                                    "https://image.tmdb.org/t/p/w500/" +
                                        topRatedMovies[index].poster_path,
                                    fit: BoxFit.fill),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => MovieDesc(
                                                      name: topRatedMovies[
                                                              index]
                                                          .title,
                                                      backdrop_path:
                                                          "https://image.tmdb.org/t/p/w500/" +
                                                              topRatedMovies[
                                                                      index]
                                                                  .backdrop_path,
                                                      overview: topRatedMovies[
                                                              index]
                                                          .overview,
                                                      released_on:
                                                          topRatedMovies[index]
                                                              .release_date,
                                                      vote_count:
                                                          topRatedMovies[index]
                                                              .vote_count,
                                                      id: topRatedMovies[index]
                                                          .id)));
                                        },
                                        icon: Icon(
                                          CupertinoIcons.info_circle,
                                          color: Colors.white,
                                        )),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      CupertinoIcons.add,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      // if (isliked2) {
                                      //   dbref.push().set(
                                      //       topRatedMovies[index].poster_path);
                                      // } else {
                                      //   //dbref.remove();
                                      // }
                                      // isliked2 = !isliked2;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: const Text(
                    "Upcoming",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 260,
                  child: ListView.builder(
                    itemCount: upcomingmovies.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MovieDesc(
                                      name: upcomingmovies[index].title,
                                      backdrop_path:
                                          "https://image.tmdb.org/t/p/w500/" +
                                              upcomingmovies[index]
                                                  .backdrop_path,
                                      overview: upcomingmovies[index].overview,
                                      released_on:
                                          upcomingmovies[index].release_date,
                                      vote_count:
                                          upcomingmovies[index].vote_count,
                                      id: upcomingmovies[index].id)));
                        },
                        child: Container(
                          width: 140,
                          child: Column(
                            children: [
                              Card(
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                elevation: 5,
                                child: Image.network(
                                    "https://image.tmdb.org/t/p/w500/" +
                                        upcomingmovies[index].poster_path,
                                    fit: BoxFit.fill),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => MovieDesc(
                                                      name: upcomingmovies[
                                                              index]
                                                          .title,
                                                      backdrop_path:
                                                          "https://image.tmdb.org/t/p/w500/" +
                                                              upcomingmovies[
                                                                      index]
                                                                  .backdrop_path,
                                                      overview: upcomingmovies[
                                                              index]
                                                          .overview,
                                                      released_on:
                                                          upcomingmovies[index]
                                                              .release_date,
                                                      vote_count:
                                                          upcomingmovies[index]
                                                              .vote_count,
                                                      id: upcomingmovies[index]
                                                          .id)));
                                        },
                                        icon: Icon(
                                          CupertinoIcons.info_circle,
                                          color: Colors.white,
                                        )),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      CupertinoIcons.add,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      // if (isliked3) {
                                      //   dbref.push().set(
                                      //       upcomingmovies[index].poster_path);
                                      // } else {
                                      //   //dbref.remove();
                                      // }
                                      // isliked3 = !isliked3;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: const Text(
                    "Popular",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 260,
                  child: ListView.builder(
                    itemCount: popularmovies.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MovieDesc(
                                      name: popularmovies[index].title,
                                      backdrop_path:
                                          "https://image.tmdb.org/t/p/w500/" +
                                              popularmovies[index]
                                                  .backdrop_path,
                                      overview: popularmovies[index].overview,
                                      released_on:
                                          popularmovies[index].release_date,
                                      vote_count:
                                          popularmovies[index].vote_count,
                                      id: popularmovies[index].id)));
                        },
                        child: Container(
                          width: 140,
                          child: Column(
                            children: [
                              Card(
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                elevation: 5,
                                child: Image.network(
                                    "https://image.tmdb.org/t/p/w500/" +
                                        popularmovies[index].poster_path,
                                    fit: BoxFit.fill),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => MovieDesc(
                                                      name: popularmovies[index]
                                                          .title,
                                                      backdrop_path:
                                                          "https://image.tmdb.org/t/p/w500/" +
                                                              popularmovies[
                                                                      index]
                                                                  .backdrop_path,
                                                      overview:
                                                          popularmovies[index]
                                                              .overview,
                                                      released_on:
                                                          popularmovies[index]
                                                              .release_date,
                                                      vote_count:
                                                          popularmovies[index]
                                                              .vote_count,
                                                      id: popularmovies[index]
                                                          .id)));
                                        },
                                        icon: Icon(
                                          CupertinoIcons.info_circle,
                                          color: Colors.white,
                                        )),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      CupertinoIcons.add,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      // if (isliked4) {
                                      //   dbref.push().set(
                                      //       popularmovies[index].poster_path);
                                      // } else {
                                      //   //dbref.remove();
                                      // }
                                      // isliked4 = !isliked4;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: const Text(
                    "Action",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 260,
                  child: ListView.builder(
                    itemCount: actionmovies.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MovieDesc(
                                      name: actionmovies[index].title,
                                      backdrop_path:
                                          "https://image.tmdb.org/t/p/w500/" +
                                              actionmovies[index].backdrop_path,
                                      overview: actionmovies[index].overview,
                                      released_on:
                                          actionmovies[index].release_date,
                                      vote_count:
                                          actionmovies[index].vote_count,
                                      id: actionmovies[index].id)));
                        },
                        child: Container(
                          width: 140,
                          child: Column(
                            children: [
                              Card(
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                elevation: 5,
                                child: Image.network(
                                    "https://image.tmdb.org/t/p/w500/" +
                                        actionmovies[index].poster_path,
                                    fit: BoxFit.fill),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => MovieDesc(
                                                      name: actionmovies[index]
                                                          .title,
                                                      backdrop_path:
                                                          "https://image.tmdb.org/t/p/w500/" +
                                                              actionmovies[
                                                                      index]
                                                                  .backdrop_path,
                                                      overview:
                                                          actionmovies[index]
                                                              .overview,
                                                      released_on:
                                                          actionmovies[index]
                                                              .release_date,
                                                      vote_count:
                                                          actionmovies[index]
                                                              .vote_count,
                                                      id: actionmovies[index]
                                                          .id)));
                                        },
                                        icon: Icon(
                                          CupertinoIcons.info_circle,
                                          color: Colors.white,
                                        )),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      CupertinoIcons.add,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      // if (isliked5) {
                                      //   dbref.push().set(
                                      //       actionmovies[index].poster_path);
                                      // } else {
                                      //   //dbref.remove();
                                      // }
                                      // isliked5 = !isliked5;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: const Text(
                    "Adventure",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 260,
                  child: ListView.builder(
                    itemCount: adventuremovies.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MovieDesc(
                                      name: adventuremovies[index].title,
                                      backdrop_path:
                                          "https://image.tmdb.org/t/p/w500/" +
                                              adventuremovies[index]
                                                  .backdrop_path,
                                      overview: adventuremovies[index].overview,
                                      released_on:
                                          adventuremovies[index].release_date,
                                      vote_count:
                                          adventuremovies[index].vote_count,
                                      id: adventuremovies[index].id)));
                        },
                        child: Container(
                          width: 140,
                          child: Column(
                            children: [
                              Card(
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                elevation: 5,
                                child: Image.network(
                                    "https://image.tmdb.org/t/p/w500/" +
                                        adventuremovies[index].poster_path,
                                    fit: BoxFit.fill),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => MovieDesc(
                                                      name: adventuremovies[
                                                              index]
                                                          .title,
                                                      backdrop_path:
                                                          "https://image.tmdb.org/t/p/w500/" +
                                                              adventuremovies[
                                                                      index]
                                                                  .backdrop_path,
                                                      overview:
                                                          adventuremovies[index]
                                                              .overview,
                                                      released_on:
                                                          adventuremovies[index]
                                                              .release_date,
                                                      vote_count:
                                                          adventuremovies[index]
                                                              .vote_count,
                                                      id: adventuremovies[index]
                                                          .id)));
                                        },
                                        icon: Icon(
                                          CupertinoIcons.info_circle,
                                          color: Colors.white,
                                        )),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      CupertinoIcons.add,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      // if (isliked6) {
                                      //   dbref.push().set(
                                      //       actionmovies[index].poster_path);
                                      // } else {
                                      //   //dbref.remove();
                                      // }
                                      // isliked6 = !isliked6;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: const Text(
                    "Comedy",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 260,
                  child: ListView.builder(
                    itemCount: comedymovies.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MovieDesc(
                                      name: comedymovies[index].title,
                                      backdrop_path:
                                          "https://image.tmdb.org/t/p/w500/" +
                                              comedymovies[index].backdrop_path,
                                      overview: comedymovies[index].overview,
                                      released_on:
                                          comedymovies[index].release_date,
                                      vote_count:
                                          comedymovies[index].vote_count,
                                      id: comedymovies[index].id)));
                        },
                        child: Container(
                          width: 140,
                          child: Column(
                            children: [
                              Card(
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                elevation: 5,
                                child: Image.network(
                                    "https://image.tmdb.org/t/p/w500/" +
                                        comedymovies[index].poster_path,
                                    fit: BoxFit.fill),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => MovieDesc(
                                                      name: comedymovies[index]
                                                          .title,
                                                      backdrop_path:
                                                          "https://image.tmdb.org/t/p/w500/" +
                                                              comedymovies[
                                                                      index]
                                                                  .backdrop_path,
                                                      overview:
                                                          comedymovies[index]
                                                              .overview,
                                                      released_on:
                                                          comedymovies[index]
                                                              .release_date,
                                                      vote_count:
                                                          comedymovies[index]
                                                              .vote_count,
                                                      id: comedymovies[index]
                                                          .id)));
                                        },
                                        icon: Icon(
                                          CupertinoIcons.info_circle,
                                          color: Colors.white,
                                        )),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      CupertinoIcons.add,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      // if (isliked7) {
                                      //   dbref.push().set(
                                      //       actionmovies[index].poster_path);
                                      // } else {
                                      //   //dbref.remove();
                                      // }
                                      // isliked7 = !isliked7;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: const Text(
                    "Thriller",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 260,
                  child: ListView.builder(
                    itemCount: thrillermovies.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MovieDesc(
                                      name: thrillermovies[index].title,
                                      backdrop_path:
                                          "https://image.tmdb.org/t/p/w500/" +
                                              thrillermovies[index]
                                                  .backdrop_path,
                                      overview: thrillermovies[index].overview,
                                      released_on:
                                          thrillermovies[index].release_date,
                                      vote_count:
                                          thrillermovies[index].vote_count,
                                      id: thrillermovies[index].id)));
                        },
                        child: Container(
                          width: 140,
                          child: Column(
                            children: [
                              Card(
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                elevation: 5,
                                child: Image.network(
                                    "https://image.tmdb.org/t/p/w500/" +
                                        thrillermovies[index].poster_path,
                                    fit: BoxFit.fill),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => MovieDesc(
                                                      name: thrillermovies[
                                                              index]
                                                          .title,
                                                      backdrop_path:
                                                          "https://image.tmdb.org/t/p/w500/" +
                                                              thrillermovies[
                                                                      index]
                                                                  .backdrop_path,
                                                      overview: thrillermovies[
                                                              index]
                                                          .overview,
                                                      released_on:
                                                          thrillermovies[index]
                                                              .release_date,
                                                      vote_count:
                                                          thrillermovies[index]
                                                              .vote_count,
                                                      id: thrillermovies[index]
                                                          .id)));
                                        },
                                        icon: Icon(
                                          CupertinoIcons.info_circle,
                                          color: Colors.white,
                                        )),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      CupertinoIcons.add,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      // if (isliked8) {
                                      //   dbref.push().set(
                                      //       actionmovies[index].poster_path);
                                      // } else {
                                      //   //dbref.remove();
                                      // }
                                      // isliked8 = !isliked8;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: const Text(
                    "Sci Fi",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 260,
                  child: ListView.builder(
                    itemCount: scifimovies.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MovieDesc(
                                      name: scifimovies[index].title,
                                      backdrop_path:
                                          "https://image.tmdb.org/t/p/w500/" +
                                              scifimovies[index].backdrop_path,
                                      overview: scifimovies[index].overview,
                                      released_on:
                                          scifimovies[index].release_date,
                                      vote_count: scifimovies[index].vote_count,
                                      id: scifimovies[index].id)));
                        },
                        child: Container(
                          width: 140,
                          child: Column(
                            children: [
                              Card(
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                elevation: 5,
                                child: Image.network(
                                    "https://image.tmdb.org/t/p/w500/" +
                                        scifimovies[index].poster_path,
                                    fit: BoxFit.fill),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => MovieDesc(
                                                      name:
                                                          scifimovies[index]
                                                              .title,
                                                      backdrop_path:
                                                          "https://image.tmdb.org/t/p/w500/" +
                                                              scifimovies[index]
                                                                  .backdrop_path,
                                                      overview:
                                                          scifimovies[index]
                                                              .overview,
                                                      released_on:
                                                          scifimovies[index]
                                                              .release_date,
                                                      vote_count:
                                                          scifimovies[index]
                                                              .vote_count,
                                                      id: scifimovies[index]
                                                          .id)));
                                        },
                                        icon: Icon(
                                          CupertinoIcons.info_circle,
                                          color: Colors.white,
                                        )),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      CupertinoIcons.add,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      // if (isliked9) {
                                      //   dbref.push().set(
                                      //       actionmovies[index].poster_path);
                                      // } else {
                                      //   //dbref.remove();
                                      // }
                                      // isliked9 = !isliked9;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: const Text(
                    "Horror",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 260,
                  child: ListView.builder(
                    itemCount: horrormovies.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MovieDesc(
                                      name: horrormovies[index].title,
                                      backdrop_path:
                                          "https://image.tmdb.org/t/p/w500/" +
                                              horrormovies[index].backdrop_path,
                                      overview: horrormovies[index].overview,
                                      released_on:
                                          horrormovies[index].release_date,
                                      vote_count:
                                          horrormovies[index].vote_count,
                                      id: horrormovies[index].id)));
                        },
                        child: Container(
                          width: 140,
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
                                        horrormovies[index].poster_path,
                                    fit: BoxFit.fill),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => MovieDesc(
                                                      name: horrormovies[index]
                                                          .title,
                                                      backdrop_path:
                                                          "https://image.tmdb.org/t/p/w500/" +
                                                              horrormovies[
                                                                      index]
                                                                  .backdrop_path,
                                                      overview:
                                                          horrormovies[index]
                                                              .overview,
                                                      released_on:
                                                          horrormovies[index]
                                                              .release_date,
                                                      vote_count:
                                                          horrormovies[index]
                                                              .vote_count,
                                                      id: horrormovies[index]
                                                          .id)));
                                        },
                                        icon: Icon(
                                          CupertinoIcons.info_circle,
                                          color: Colors.white,
                                        )),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      CupertinoIcons.add,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      // if (isliked10) {
                                      //   dbref.push().set(
                                      //       actionmovies[index].poster_path);
                                      // } else {
                                      //   //dbref.remove();
                                      // }
                                      // isliked10 = !isliked10;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: const Text(
                    "History",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 260,
                  child: ListView.builder(
                    itemCount: historymovies.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MovieDesc(
                                      name: historymovies[index].title,
                                      backdrop_path:
                                          "https://image.tmdb.org/t/p/w500/" +
                                              historymovies[index]
                                                  .backdrop_path,
                                      overview: historymovies[index].overview,
                                      released_on:
                                          historymovies[index].release_date,
                                      vote_count:
                                          historymovies[index].vote_count,
                                      id: historymovies[index].id)));
                        },
                        child: Container(
                          width: 140,
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
                                        historymovies[index].poster_path,
                                    fit: BoxFit.fill),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => MovieDesc(
                                                      name: historymovies[index]
                                                          .title,
                                                      backdrop_path:
                                                          "https://image.tmdb.org/t/p/w500/" +
                                                              historymovies[
                                                                      index]
                                                                  .backdrop_path,
                                                      overview:
                                                          historymovies[index]
                                                              .overview,
                                                      released_on:
                                                          historymovies[index]
                                                              .release_date,
                                                      vote_count:
                                                          historymovies[index]
                                                              .vote_count,
                                                      id: historymovies[index]
                                                          .id)));
                                        },
                                        icon: Icon(
                                          CupertinoIcons.info_circle,
                                          color: Colors.white,
                                        )),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      CupertinoIcons.add,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      // if (isliked11) {
                                      //   dbref.push().set(
                                      //       actionmovies[index].poster_path);
                                      // } else {
                                      //   //dbref.remove();
                                      // }
                                      // isliked11 = !isliked11;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: const Text(
                    "Documentries",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 260,
                  child: ListView.builder(
                    itemCount: documentry.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MovieDesc(
                                      name: documentry[index].title,
                                      backdrop_path:
                                          "https://image.tmdb.org/t/p/w500/" +
                                              documentry[index].backdrop_path,
                                      overview: documentry[index].overview,
                                      released_on:
                                          documentry[index].release_date,
                                      vote_count: documentry[index].vote_count,
                                      id: documentry[index].id)));
                        },
                        child: Container(
                          width: 140,
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
                                        documentry[index].poster_path,
                                    fit: BoxFit.fill),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => MovieDesc(
                                                      name: documentry[index]
                                                          .title,
                                                      backdrop_path:
                                                          "https://image.tmdb.org/t/p/w500/" +
                                                              documentry[index]
                                                                  .backdrop_path,
                                                      overview:
                                                          documentry[index]
                                                              .overview,
                                                      released_on:
                                                          documentry[index]
                                                              .release_date,
                                                      vote_count:
                                                          documentry[index]
                                                              .vote_count,
                                                      id: documentry[index]
                                                          .id)));
                                        },
                                        icon: Icon(
                                          CupertinoIcons.info_circle,
                                          color: Colors.white,
                                        )),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      CupertinoIcons.add,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      // if (isliked12) {
                                      //   dbref.push().set(
                                      //       actionmovies[index].poster_path);
                                      // } else {
                                      //   //dbref.remove();
                                      // }
                                      // isliked12 = !isliked12;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: const Text(
                    "Music",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 260,
                  child: ListView.builder(
                    itemCount: music.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MovieDesc(
                                      name: music[index].title,
                                      backdrop_path:
                                          "https://image.tmdb.org/t/p/w500/" +
                                              music[index].backdrop_path,
                                      overview: music[index].overview,
                                      released_on: music[index].release_date,
                                      vote_count: music[index].vote_count,
                                      id: music[index].id)));
                        },
                        child: Container(
                          width: 140,
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
                                        music[index].poster_path,
                                    fit: BoxFit.fill),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => MovieDesc(
                                                      name: music[index].title,
                                                      backdrop_path:
                                                          "https://image.tmdb.org/t/p/w500/" +
                                                              music[index]
                                                                  .backdrop_path,
                                                      overview:
                                                          music[index].overview,
                                                      released_on: music[index]
                                                          .release_date,
                                                      vote_count: music[index]
                                                          .vote_count,
                                                      id: music[index].id)));
                                        },
                                        icon: Icon(
                                          CupertinoIcons.info_circle,
                                          color: Colors.white,
                                        )),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      CupertinoIcons.add,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      // if (isliked13) {
                                      //   dbref.push().set(
                                      //       actionmovies[index].poster_path);
                                      // } else {
                                      //   //dbref.remove();
                                      // }
                                      // isliked13 = !isliked13;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
