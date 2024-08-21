import 'package:get/get.dart';

class RegistrationController extends GetxController{
  bool _inProgress=false;
  String _token='';

  get inProgress => _inProgress;

  Future<bool> register({String name='Name',String email='email',String password='password'})async{
    bool isSuccess=false;
    _inProgress=true;
    update();

    return isSuccess;
  }

}