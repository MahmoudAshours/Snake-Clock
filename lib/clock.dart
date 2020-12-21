import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:core';

class Clock extends StatefulWidget {
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  List numberOfBlocks = List();
  DateTime _dateTime = DateTime.now();
  Timer _timer;
  final firstColor = Colors.pink;
  final secondColor = Colors.black;

  @override
  void initState() {
    _updateTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: firstColor,
      body: Center(
        child: Row(
          children: [
            blocks((_dateTime.hour / 10).floor()),
            blocks((_dateTime.hour % 10).floor()),
            blocks(':'),
            blocks((_dateTime.minute / 10).floor()),
            blocks((_dateTime.minute % 10).floor()),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
    );
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
      _timer = Timer(
        Duration(minutes: 1) -
            Duration(seconds: _dateTime.second) -
            Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
    });
  }

  Widget blocks(digit) {
    List digitLocations = _numberBlocks(digit.toString());
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width / 7,
          height: 400,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 4),
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 10,
                offset: Offset(30, 0),
              )
            ],
          ),
          child: GridView(
            children: [
              for (var index = 0; index < 15; index++)
                AnimatedContainer(
                  duration: Duration(milliseconds: index * 140),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: digitLocations.contains(index) ? secondColor : firstColor,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                        spreadRadius: 1,
                        color: secondColor,
                      ),
                    ],
                    border: Border.all(
                      color: digitLocations.contains(index) ? firstColor : secondColor,
                      width: 0.3,
                      style: BorderStyle.solid,
                    ),
                  ),
                )
            ],
            addAutomaticKeepAlives: false,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          ),
        ),
      ),
    );
  }

  _numberBlocks(String digit) {
    numberOfBlocks.clear();
    switch (digit) {
      case '0':
        numberOfBlocks.addAll([0, 1, 2, 3, 5, 6, 8, 9, 11, 12, 13, 14]);
        break;
      case '1':
        numberOfBlocks.addAll([1, 4, 7, 10, 13]);
        break;
      case '2':
        numberOfBlocks.addAll([0, 1, 2, 5, 6, 7, 8, 9, 12, 13, 14]);
        break;
      case '3':
        numberOfBlocks.addAll([0, 1, 2, 5, 6, 7, 8, 11, 12, 13, 14]);
        break;
      case '4':
        numberOfBlocks.addAll([0, 3, 5, 6, 7, 8, 11, 14]);
        break;
      case '5':
        numberOfBlocks.addAll([0, 1, 2, 3, 6, 7, 8, 11, 12, 13, 14]);
        break;
      case '6':
        numberOfBlocks.addAll([0, 1, 2, 3, 6, 7, 8, 9, 11, 12, 13, 14]);
        break;
      case '7':
        numberOfBlocks.addAll([0, 1, 2, 5, 8, 11, 14]);
        break;
      case '8':
        numberOfBlocks.addAll([0, 1, 2, 3, 5, 6, 7, 8, 9, 11, 12, 13, 14]);
        break;
      case '9':
        numberOfBlocks.addAll([0, 1, 2, 3, 5, 6, 7, 8, 11, 14]);
        break;
      case ':':
        numberOfBlocks.addAll([4, 10]);
        break;
      default:
    }
    return numberOfBlocks;
  }
}
