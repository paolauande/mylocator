import 'package:flutter/material.dart';
import 'package:mylocator/widgets/styles.dart';

GestureDetector myBtn(String text, onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 300,
      height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [highlightColor, defaultColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          text,
          style: whiteText20,
        ),
      ),
    ),
  );
}

appBar(String title) {
  return AppBar(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
      iconTheme: IconThemeData(color: Colors.black),
      centerTitle: true,
      elevation: 5,
      backgroundColor: Colors.teal[100],
      title: Text(title, style: hightlightText));
}
