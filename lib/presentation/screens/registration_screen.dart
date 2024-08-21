import 'package:flutter/material.dart';
import 'package:social_media_app/presentation/utils/app_colors.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameTEController = TextEditingController();
  final _nameFocusNode= FocusNode();
  final TextEditingController _emailTEController = TextEditingController();
  final _emailFocusNode= FocusNode();
  final TextEditingController _passwordTEController = TextEditingController();
  final _passwordFocusNode= FocusNode();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();
  final _confirmPasswordFocusNode= FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height*0.13,),
              Text(
                'Enter your email & password to register with us.',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.07,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    nameField(context),
                    emailField(context),
                    passwordField(context),
                    confirmPasswordField(context),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.03,
                    ),
                    registerButton(context),
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

  ElevatedButton registerButton(BuildContext context) {
    return ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                    child: Text(
                      'Register',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.white,
                          ),
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
          focusNode: _confirmPasswordFocusNode,
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
          onFieldSubmitted: (text){
            _confirmPasswordFocusNode.unfocus();
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
          focusNode: _passwordFocusNode,
          cursorColor: AppColors.accentColor,
          decoration: const InputDecoration(
            hintText: 'Enter Password',
            prefixIcon: Icon(Icons.lock_outline),
          ),
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
          onFieldSubmitted: (text){
            _confirmPasswordFocusNode.requestFocus();
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
          focusNode: _emailFocusNode,
          cursorColor: AppColors.accentColor,
          decoration: const InputDecoration(
            hintText: 'Enter Email',
            prefixIcon: Icon(Icons.mail_outline),
          ),
          validator: (input) {
            if (input == null || input == '') {
              return 'Empty Email';
            } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(input.trim())) {
              return "Invalid Email Format";
            } else {
              return null;
            }
          },
          onFieldSubmitted: (text){
            _passwordFocusNode.requestFocus();
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
          focusNode: _nameFocusNode,
          cursorColor: AppColors.accentColor,
          decoration: const InputDecoration(
            hintText: 'Enter Name',
            prefixIcon: Icon(Icons.person_2_outlined),
          ),
          validator: (input) {
            if (input == null || input == '') {
              return 'Empty Name';
            }else {
              return null;
            }
          },
          onFieldSubmitted: (text){
            _emailFocusNode.requestFocus();
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
    super.dispose();
  }
}
