import 'package:flutter/material.dart';
import 'package:get/get.dart';

snackBar({required String title, String? message,Color? color}){
  Get.showSnackbar(
    GetSnackBar(
      titleText: Text(
        title,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
      messageText: Text(
        message??'',
        style: TextStyle(
          color: color,
        ),
      ),
      backgroundColor: Colors.black26,
      duration: Duration(seconds: 3),
    )
  );
}