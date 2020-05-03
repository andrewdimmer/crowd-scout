import 'package:flutter/material.dart';

Widget loadingWheelAndMessage(String message) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        Center(
          child: Text(message),
        ),
      ],
    );
