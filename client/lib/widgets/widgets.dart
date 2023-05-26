import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  labelStyle: TextStyle(color: Color(0xFF6200EE), fontWeight: FontWeight.w300),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF6200EE), width: 2),
    borderRadius: BorderRadius.all(Radius.circular(60)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF6200EE), width: 2),
    borderRadius: BorderRadius.all(Radius.circular(60)),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF6200EE), width: 2),
    borderRadius: BorderRadius.all(Radius.circular(60)),
  ),
);

void nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenReplace(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenRemoveUntil(context, page) {
  Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => page), (route) => false);
}
