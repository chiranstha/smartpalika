import 'package:flutter/material.dart';

Color? bluesColor = Colors.blue[800];
Color? redsColor = Colors.red;

textStyle() {
  return const TextStyle(
      fontSize: 16, fontWeight: FontWeight.w500, color: Colors.blueGrey);
}

simpletextStyle() {
  return const TextStyle(
      fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black);
}

mediumtextStyle(Color color) {
  return TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: color);
}

boldtextStyle(Color color) {
  return TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color);
}

ratetextStyle(Color color) {
  return TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color);
}

const appColor = Color(0xFF6F67FE);
const appColor2 = Color(0xFFB446FF);

const demoText =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget augue quam. Donec bibendum justo sed magna ornare vehicula. Nulla facilisi. Morbi vehicula velit eget malesuada varius. Etiam nec nisl ac metus blandit elementum. Donec eu cursus velit. Proin nunc lacus, gravida mollis suscipit ut, faucibus non eros. Sed vitae arcu in risus pulvinar aliquam.';
