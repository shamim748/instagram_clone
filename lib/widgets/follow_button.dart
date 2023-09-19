import 'package:flutter/material.dart';

Widget followbutton(
    {required Function() onpressed,
    required Color backgraoundcolor,
    required Color borderColor,
    required String title,
    required Color textColor}) {
  return Container(
    padding: const EdgeInsets.only(top: 2),
    child: TextButton(
        onPressed: onpressed,
        child: Container(
          decoration: BoxDecoration(
            color: backgraoundcolor,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          width: 250,
          height: 27,
          child: Text(
            title,
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          ),
        )),
  );
}
