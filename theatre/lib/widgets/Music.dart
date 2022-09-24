import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:theatre/pages/Description.dart';

import 'package:theatre/utils/routes.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../widgets/drawer.dart';
class Music {
  final dynamic title,
      overview,
      poster_path,
      original_language,
      vote_count,
      release_date,
      backdrop_path,
      id;

  Music(
      {this.title,
      this.overview,
      this.poster_path,
      this.original_language,
      this.vote_count,
      this.release_date,
      this.backdrop_path,
      this.id});
  factory Music.fromJson(Map<String, dynamic> json) {
    return Music(
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