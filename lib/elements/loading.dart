import 'package:flutter/material.dart';
import 'package:quotes/main.dart';

Widget buildLoading() {
  return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 0.0339*height,
            width: 0.06944*width,
            child: CircularProgressIndicator(
              valueColor:
              new AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 0.0111*width,
            ),
          )
        ],
      ));
}
