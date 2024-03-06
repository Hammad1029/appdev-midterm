import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:appdev_midterm/model.dart';
import 'package:appdev_midterm/missionCard.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key, required this.getData});

  final Future<List<Launch>> Function() getData;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Text("ERROR");
            } else if (!snapshot.hasData) {
              return const Text("NO DATA FOUND");
            }
            return ListView.builder(
                itemBuilder: (BuildContext context, int idx) {
                  var data = snapshot.data?.elementAt(idx) ?? Launch();
                  return Container(
                      margin: const EdgeInsets.all(20),
                      child: MissionCard(data: data));
                },
                itemCount: snapshot.data?.length);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
