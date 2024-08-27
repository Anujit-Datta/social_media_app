import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/presentation/controllers/auth_shared_pref.dart';
import 'package:social_media_app/presentation/widgets/snackbar.dart';

import '../../data/models/user_model.dart';

class RegistrationController extends GetxController{
  final _auth =FirebaseAuth.instance;
  final _data =FirebaseFirestore.instance;
  bool _inProgress=false;

  get inProgress => _inProgress;

  Future<bool> register({String name='Name',String email='email',String password='password'})async{
    bool isSuccess=false;
    _inProgress=true;
    update();


    List list= email.split('@');
    String username= list[0];

    await _auth.createUserWithEmailAndPassword(email: email, password: password)
        .then((userCredential)async{
          if(userCredential.user != null){
            await _data.collection('User').doc(userCredential.user!.uid).set(
                UserModel(
                  uid: userCredential.user!.uid,
                  name: name,
                  username: username,
                  email: email,
                ).toJson()
            ).whenComplete((){
              AuthController.setToken(userCredential.user!.uid);
              snackBar(title: 'Registration Successful',color: Colors.green);
            }).catchError((e){
              snackBar(title: 'Registration Error!',message: e.toString(),color: Colors.red);
            });
          }
        }).catchError((e){
          snackBar(title: 'Authentication Error!',message: e.toString(),color: Colors.red);
    });


    _inProgress=false;
    update();
    return isSuccess;
  }

}