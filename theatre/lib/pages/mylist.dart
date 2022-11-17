import 'dart:convert';
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

final List<String> values = [];
final List<String> list = [];

class MyList extends StatefulWidget {
  const MyList({super.key});
  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  DatabaseReference dbref = FirebaseDatabase.instance
      .ref()
      .child("Liked Videos")
      .child(FirebaseAuth.instance.currentUser!.uid);
  @override
  void initState() {
    DatabaseReference dbref = FirebaseDatabase.instance
        .ref()
        .child('Liked Videos')
        .child(FirebaseAuth.instance.currentUser!.uid);
    super.initState();
  }

  Widget listItem({required Map dataset}) {
    return Container(
      height: 260,
      width: 140,
      child: Column(
        children: [
          Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            elevation: 5,
            color: Colors.transparent,
            child: Column(
              children: [
                Image.network(dataset['key']),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: Colors.black,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56), child: MyAppBar()),
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
                query: dbref,
                itemBuilder: ((BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  Map dataset = snapshot.value as Map;
                  dataset['key'] = snapshot.key;
                  return listItem(dataset: dataset);
                })),
          ),
        ],
      ),
    );
  }
}
