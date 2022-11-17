import 'dart:convert';
import 'package:get/state_manager.dart';
class Movies{
  final dynamic name;
  final dynamic posterpath;

  Movies({
    this.name,
    this.posterpath,
  });

  final isFavorite = false.obs;
}