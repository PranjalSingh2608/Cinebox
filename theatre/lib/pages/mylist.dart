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

// class Data {
//   final dynamic image, key;
//   const Data({
//     required this.image,
//     required this.key,
//   });

//   factory Data.fromMap(Map<dynamic, dynamic> map) {
//     return Data(
//       image: map['image'] ?? '',
//       key: map['key'] ?? '',
//     );
//   }
// }

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
  // @override
  // void initState() {
  //   print("Hello");
  //   getUsers();
  //   DatabaseReference dbref = FirebaseDatabase.instance
  //       .ref()
  //       .child('Liked Videos')
  //       .child(FirebaseAuth.instance.currentUser!.uid);
  //   super.initState();
  // }

  getUsers() async {
    final snapshot = await FirebaseDatabase.instance
        .ref("Liked Videos")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (snapshot.exists) {
      print(snapshot.value);
    } else {
      Fluttertoast.showToast(
        msg: "No Data", // message
        toastLength: Toast.LENGTH_SHORT, // length
        gravity: ToastGravity.CENTER, // location
      );
    }
    final map = snapshot.value as Map<dynamic, dynamic>;

    final values = map.values as Iterable;
    values.forEach((element) {
      print("https://image.tmdb.org/t/p/w500" + element);
      list.add(element);
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
                // const Text(
                //   "Liked Movies",
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //     fontSize: 22,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.white,
                //   ),
                // ),
                SizedBox(
                  height: 280,
                ),
                // GridView.count(
                //   physics: ScrollPhysics(),
                //   crossAxisCount: 3,
                //   mainAxisSpacing: 30,
                //   crossAxisSpacing: 5,
                //   childAspectRatio: 0.5,
                //   shrinkWrap: true,
                //   scrollDirection: Axis.vertical,
                //   children: new List<Widget>.generate(values.length, (index) {
                //     return Container(
                //       child: Column(
                //         children: [
                //           Image.network(
                //               "https://image.tmdb.org/t/p/w500/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg"),
                //           Card(
                //             color: Colors.white,
                //             child: Padding(
                //               padding: EdgeInsets.all(10),
                //               child: Column(
                //                 children: [
                //                   Ink.image(
                //                     image: NetworkImage(
                //                         'https://image.tmdb.org/t/p/w500/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg'),
                //                     height: 240,
                //                     fit: BoxFit.fitHeight,
                //                   )
                //                 ],
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     );
                //   }),
                // ),
                Container(
                  child: Center(
                    child: const Text(
                      "Feature Coming Soon",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                  // height: MediaQuery.of(context).size.height,
                  // child: ListView.builder(
                  //   itemCount: list.length,
                  //   scrollDirection: Axis.vertical,
                  //   itemBuilder: (context, index) {
                  //     return InkWell(
                  //       onTap: () {},
                  //       child: Container(
                  //         width: 140,
                  //         child: Column(
                  //           children: [
                  //             //Card(
                  //             // semanticContainer: true,
                  //             // clipBehavior: Clip.antiAliasWithSaveLayer,
                  //             // shape: RoundedRectangleBorder(
                  //             //     borderRadius: BorderRadius.circular(10.0)),
                  //             // elevation: 5,
                  //             Image.network(
                  //                 "https://image.tmdb.org/t/p/w500/" +
                  //                     list[index],
                  //                 fit: BoxFit.fill),
                  //             //),
                  //           ],
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
