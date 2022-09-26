import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:theatre/widgets/appbar.dart';
import 'package:theatre/widgets/drawer.dart';

import 'description.dart';

class Videos {
  final dynamic poster;
  const Videos({
    required this.poster,
  });
  factory Videos.fromMap(Map<dynamic, dynamic> map) {
    return Videos(
      poster: map['poster'] ?? '',
    );
  }
}

final List<Videos> list = [];

getUsers() async {
  final snapshot = await FirebaseDatabase.instance.ref('users').get();

  final map = snapshot.value as Map<dynamic, dynamic>;

  map.forEach((key, value) {
    final user = Videos.fromMap(value);
    list.add(user);
  });
}

class LikedVideos extends StatefulWidget {
  const LikedVideos({super.key});

  @override
  State<LikedVideos> createState() => _LikedVideosState();
}

class _LikedVideosState extends State<LikedVideos> {
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
              children: [
                const Text(
                  "Liked Movies",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GridView.count(
                  crossAxisCount: 3,
                  physics: ScrollPhysics(),
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 5,
                  childAspectRatio: 0.5,
                  shrinkWrap:true,
                  scrollDirection: Axis.vertical,
                  children:new List<Widget>.generate(list.length, (index){
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
                                          list[index].poster,
                                      fit: BoxFit.fill),
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
