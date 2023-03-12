import 'package:flutter/material.dart';

const primaryColor = Color.fromARGB(255, 6, 17, 38);
var sbox = SizedBox(
  height: 20,
);

Widget sbox2({  required double sheight}) {
  return SizedBox(
    height: sheight,
  );
}
Widget text_privacy_policy(String _text) {
  return Text(
    _text,
    style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        color: Colors.white,
        fontSize: 12),
  );
}

Widget text_privacy_policy2(String _text2, double _textsize) {
  return Text(
    _text2,
    style: TextStyle(
        color: Colors.white,
        fontSize: _textsize,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold),
);
}

//search page


