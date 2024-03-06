import 'package:flutter/material.dart';
import 'package:appdev_midterm/model.dart';
import 'dart:math' as math;

class MissionCard extends StatefulWidget {
  final Launch data;
  const MissionCard({Key? key, required this.data}) : super(key: key);

  @override
  State<MissionCard> createState() => MissionCardState();
}

class MissionCardState extends State<MissionCard> {
  bool show = false;
  List<Color> colors = List.empty();

  @override
  initState() {
    super.initState();
    setState(() {
      colors = widget.data.payloadIds!.map<Color>((e) {
        return Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
            .withOpacity(1.0);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Flexible(
          child: Column(
            children: [
              Row(
                children: [
                  Wrap(
                    children: [
                      Text(widget.data.missionName.toString(),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500))
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: show
                          ? SizedBox(
                              width: 350,
                              child: Text(widget.data.description.toString(),
                                  style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600)),
                            )
                          : Text(
                              "${widget.data.description.toString().substring(0, 52)}...",
                              style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                    child: ElevatedButton.icon(
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(int.parse("#d3d3d3".substring(1, 7),
                                        radix: 16) +
                                    0xFF000000)),
                            shape:
                                MaterialStateProperty.all<RoundedRectangleBorder>(
                                    const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ))),
                        onPressed: () {
                          setState(() {
                            show = !show;
                          });
                        },
                        icon: Icon(
                            show ? Icons.arrow_upward : Icons.arrow_downward),
                        label: Text(show ? "Less" : "More",
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600))),
                  )
                ],
              ),
              Wrap(
                children: widget.data.payloadIds?.map<Widget>((e) {
                      return Container(
                        margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Chip(
                            label: Text(e.toString()),
                            side: BorderSide.none,
                            backgroundColor: colors.elementAt(widget.data.payloadIds!.indexOf(e)),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                      );
                    }).toList() ??
                    List.empty(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
