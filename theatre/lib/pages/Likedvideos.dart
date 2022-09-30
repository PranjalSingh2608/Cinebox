import 'dart:convert';
import 'dart:html';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:theatre/main.dart';
import 'package:theatre/widgets/appbar.dart';
import 'package:theatre/widgets/drawer.dart';

import 'description.dart';

class Data {
  final dynamic image,key;
  const Data({
    required this.image,
    required this.key,
  });

  factory Data.fromMap(Map<dynamic, dynamic> map) {
    return Data(
      image: map['image'] ?? '',
      key:map['key'] ?? '',
    );
  }
}

final List<Data> list = [];

class LikedVideos extends StatefulWidget {
  const LikedVideos({super.key});
  @override
  State<LikedVideos> createState() => _LikedVideosState();
}

class _LikedVideosState extends State<LikedVideos> {
   DatabaseReference dbref = FirebaseDatabase.instance.ref().child("Liked Videos").child(FirebaseAuth.instance.currentUser!.uid);
  @override
  void initState() {
    print("Hello");
    getUsers();
    DatabaseReference dbref = FirebaseDatabase.instance
        .ref()
        .child('Liked Videos')
        .child(FirebaseAuth.instance.currentUser!.uid);
    super.initState();
  }

  getUsers() async {
    final snapshot = await FirebaseDatabase.instance
        .ref("Liked Videos")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (snapshot.exists) {
      print(snapshot.value);
    } else {
      Fluttertoast.showToast(
        msg: "No Data",  // message
        toastLength: Toast.LENGTH_SHORT, // length
        gravity: ToastGravity.CENTER,    // location
    );

    }
    final map = snapshot.value as Map<dynamic, dynamic>;

    map.forEach((key, value) {
      final data = Data.fromMap(value);

      list.add(data);
    });
  }

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
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: new List<Widget>.generate(list.length, (index) {
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
                                    list[index].image,
                                fit: BoxFit.fill),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                // FirebaseAnimatedList(
                //   query:dbref,
                //   itemBuilder: ((BuildContext context, DataSnapshot snapshot,Animation animation, int index) {
                //      return Container(
                //       child: Column(
                //         children: [
                //           Card(
                //             semanticContainer: true,
                //             clipBehavior: Clip.antiAliasWithSaveLayer,
                //             shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(10.0)),
                //             elevation: 5,
                //             child: Image.network(
                //                 // ignore: prefer_interpolation_to_compose_strings
                //                 "https://image.tmdb.org/t/p/w500/" +
                //                     snapshot.value[],
                //                 fit: BoxFit.fill),
                //           ),
                //         ],
                //       ),
                //     );
                //   }),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
