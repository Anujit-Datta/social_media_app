import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/presentation/controllers/auth_shared_pref.dart';
import 'package:social_media_app/presentation/widgets/snackbar.dart';
import '../../data/models/user_model.dart';

class LoginController extends GetxController{
  final _auth =FirebaseAuth.instance;
  final _data =FirebaseFirestore.instance;
  bool _inProgress=false;
  UserModel? selfProfile;

  get inProgress => _inProgress;

  Future<bool> login({String email='email',String password='password'})async{
    bool isSuccess=false;
    _inProgress=true;
    update();

    await _auth.signInWithEmailAndPassword(email: email, password: password)
        .then((userCredential)async{
      if(userCredential.user != null){
        await _data.collection('User').doc(userCredential.user!.uid).get().then((docSnapshot){
          Map<String,dynamic>? doc=docSnapshot.data();
          if(doc!=null){
            isSuccess=true;
            AuthController.setToken(userCredential.user!.uid);
            selfProfile=UserModel.fromJson(doc);
            snackBar(title: 'Login Successful', color: Colors.green,message: 'Hello ${doc['name']}');
            loadSelfProfile();
          }
        }).catchError((e){
          snackBar(title: 'Registration Error!',message: e.toString(),color: Colors.red);
        });
      }
    }).catchError((e){
      snackBar(title: 'Authentication Error!',message: e.toString(),color: Colors.red);
    });

    // _inProgress=false;
    // update();
    return isSuccess;
  }

  Future<void> loadSelfProfile()async{
    _inProgress=true;
    update();
    String token=await AuthController.getToken();
    _data.collection('User').doc(token).get().then((docSnapshot){
      Map<String,dynamic>? doc=docSnapshot.data();
      if(doc!=null){
        selfProfile=UserModel.fromJson(doc);
      }
    }).whenComplete(()async{
      _inProgress=false;
      await Future.delayed(Duration(seconds: 2)).whenComplete((){
        update();
      });
    });
  }

  Future<bool> logout()async{
    bool isSuccess=false;
    _inProgress=true;
    update();

    await _auth.signOut()
        .then((userCredential)async{
      AuthController.deleteData();
      selfProfile=null;
    }).catchError((e){
      snackBar(title: 'Error!',message: e.toString(),color: Colors.red);
    });

    _inProgress=false;
    update();
    return isSuccess;
  }

}