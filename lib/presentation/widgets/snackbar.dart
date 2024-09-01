import 'package:flutter/material.dart';
import 'package:get/get.dart';

snackBar({required String title, String? message,Color? color}){
  Get.showSnackbar(
    GetSnackBar(
      titleText: Text(
        title,
        style: TextStyle(
          color: color??Colors.greenAccent,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
      messageText: Text(
        message??'',
        style: TextStyle(
          color: color??Colors.greenAccent,
        ),
      ),
      backgroundColor: Colors.black26,
      duration: Duration(seconds: 3),
    )
  );
}