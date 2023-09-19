import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppStyle {
  progressDialog(context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Image.asset(
              "assets/images/loading.gif",
              height: 100,
            ),
          );
        });
  }

  //failed snackbar
  GetSnackBar FailedSnackbar(message) => GetSnackBar(
        message: message,
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 3),
        icon: Icon(Icons.warning),
      );

  //success snackbar
  GetSnackBar SuccesSnackbar(message) => GetSnackBar(
        message: message,
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
        icon: Icon(Icons.done),
      );
}
