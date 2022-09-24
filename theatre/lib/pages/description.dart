import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:theatre/widgets/appbar.dart';

class MovieDesc extends StatefulWidget {
  final dynamic name, backdrop_path, overview, released_on, vote_count, id;

  const MovieDesc(
      {super.key,
      required this.name,
      required this.backdrop_path,
      required this.overview,
      required this.released_on,
      required this.vote_count,
      required this.id});

  @override
  State<MovieDesc> createState() => _MovieDescState();
}

class _MovieDescState extends State<MovieDesc> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56), child: MyAppBar()),
      body: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Column(
                  children: [
                    Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      elevation: 5,
                      child: Image.network(widget.backdrop_path,
                          // ignore: prefer_interpolation_to_compose_strings
                          fit: BoxFit.fill),
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            widget.name != null ? widget.name : 'Not Loaded',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              //fontFamily: 'bebas'
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            widget.overview,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 20,
                              //fontFamily: 'bebas',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Vote Count ⭐:',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 25,
                              //fontFamily: 'bebas',
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Flexible(
                          child: Text(
                            widget.vote_count.toString(),
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              //fontFamily: 'bebas',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Launch Date:',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 25,
                              //fontFamily: 'bebas',
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Flexible(
                          child: Text(
                            widget.released_on != null
                                ? widget.released_on
                                : 'Not Loaded',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              //fontFamily: 'bebas',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
