import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:social_media_app/presentation/controllers/registration_controller.dart';
import 'package:social_media_app/presentation/screens/bottom_nav_bar.dart';
import 'package:social_media_app/presentation/screens/initial_screen.dart';
import 'package:social_media_app/presentation/screens/profile_screen.dart';
import 'package:social_media_app/presentation/utils/app_colors.dart';

import 'live_home_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();
  final _fn1 = FocusNode();
  final _fn2 = FocusNode();
  final _fn3 = FocusNode();
  final _fn4 = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: GetBuilder<RegistrationController>(
        builder: (ctrl) {
          return Visibility(
            visible: !ctrl.inProgress,
            replacement: Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: AppColors.accentColor,
                size: 50,
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.sizeOf(context).height*0.01,),
                    Text(
                      'Enter your email & password to register with us.',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.05,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          nameField(context),
                          emailField(context),
                          passwordField(context),
                          confirmPasswordField(context),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.03,
                          ),
                          ElevatedButton(
                            onPressed: () async{
                              if (_formKey.currentState!.validate()) {
                                bool isSuccess=await Get.find<RegistrationController>().register(
                                  name: _nameTEController.text.trim(),
                                  email: _emailTEController.text.trim(),
                                  password: _passwordTEController.text.trim(),
                                );
                                if(isSuccess){
                                  Get.to(()=>const InitialScreen());
                                }
                              }
                            },
                            child: Text(
                              'Register',
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                          SizedBox(height: MediaQuery.sizeOf(context).height*0.05,),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  Column confirmPasswordField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Confirm Password',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.007,
        ),
        TextFormField(
          controller: _confirmPasswordTEController,
          focusNode: _fn4,
          cursorColor: AppColors.accentColor,
          decoration: const InputDecoration(
            hintText: 'Retype Password',
            prefixIcon: Icon(Icons.lock_outline),
          ),
          validator: (input) {
            if (input == null || input == '') {
              return 'Empty Password';
            } else if(_confirmPasswordTEController.text.trim().length<8){
              return 'Minimum 8 Characters long';
            } else if (_passwordTEController.text.trim() !=
                _confirmPasswordTEController.text.trim()) {
              return "Passwords Doesn't Match";
            } else {
              return null;
            }
          },
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.02,
        ),
      ],
    );
  }

  Column passwordField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.007,
        ),
        TextFormField(
          controller: _passwordTEController,
          focusNode: _fn3,
          cursorColor: AppColors.accentColor,
          decoration: const InputDecoration(
            hintText: 'Enter Password',
            prefixIcon: Icon(Icons.lock_outline),
          ),
          onFieldSubmitted: (_){
            _fn4.requestFocus();
          },
          validator: (input) {
            if (input == null || input == '') {
              return 'Empty Password';
            }else if(_passwordTEController.text.trim().length<8){
              return 'Minimum 8 Characters long';
            } else if (_passwordTEController.text.trim() !=
                _confirmPasswordTEController.text.trim()) {
              return "Passwords Doesn't Match";
            } else {
              return null;
            }
          },
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.02,
        ),
      ],
    );
  }

  Column emailField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.007,
        ),
        TextFormField(
          controller: _emailTEController,
          focusNode: _fn2,
          cursorColor: AppColors.accentColor,
          decoration: const InputDecoration(
            hintText: 'Enter Email',
            prefixIcon: Icon(Icons.mail_outline),
          ),
          onFieldSubmitted: (_){
            _fn3.requestFocus();
          },
          validator: (input) {
            if (input == null || input == '') {
              return 'Empty Email';
            } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(input.trim())) {
              return "Invalid Email Format";
            } else {
              return null;
            }
          },
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.02,
        ),
      ],
    );
  }

  Column nameField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.007,
        ),
        TextFormField(
          controller: _nameTEController,
          focusNode: _fn1,
          cursorColor: AppColors.accentColor,
          decoration: const InputDecoration(
            hintText: 'Enter Name',
            prefixIcon: Icon(Icons.person_2_outlined),
          ),
          onFieldSubmitted: (_){
            _fn2.requestFocus();
          },
          validator: (input) {
            if (input == null || input == '') {
              return 'Empty Name';
            }else {
              return null;
            }
          },
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.02,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameTEController.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
    _confirmPasswordTEController.dispose();
    _fn1.dispose();
    _fn2.dispose();
    _fn3.dispose();
    _fn4.dispose();
    super.dispose();
  }
}
