import 'package:flutter/material.dart';
import 'package:flutter_movies_app/ui/home.dart';

void main() {
  runApp(
    new MaterialApp(
      title: 'Movies App',
      home: MovieListView(),
      theme: ThemeData(
        primaryColor: Colors.blueGrey.shade500
      ),
    ),
  );
}

