import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:appdev_midterm/model.dart';
import 'package:http/http.dart' as http;
import 'package:appdev_midterm/list.dart';

void main() {
  runApp(const MyStateWidget());
}

class MyStateWidget extends StatefulWidget {
  const MyStateWidget({Key? key}) : super(key: key);

  @override
  State<MyStateWidget> createState() => MainApp();
}

class MainApp extends State<MyStateWidget> {
  Future<List<Launch>> getData() async {
    try {
      var url = Uri.https("api.spacexdata.com", "v3/missions");
      var res = await http.get(url);
      var data = json.decode(res.body) as List;
      return data.map<Launch>((i) => Launch.fromJson(i)).toList();
    } catch (e) {
      print(e);
      return List.empty();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(int.parse("#006969".substring(1, 7), radix: 16) + 0xFF000000),
          foregroundColor: Colors.white,
          title: const Text("Space Missions"),
        ),
        body: Center(child: ProductList(getData: getData)),
      ),
    );
  }
}
