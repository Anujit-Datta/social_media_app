import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:social_media_app/presentation/controllers/login_controller.dart';
import 'package:social_media_app/presentation/screens/bottom_nav_bar.dart';
import 'package:social_media_app/presentation/screens/initial_screen.dart';
import 'package:social_media_app/presentation/screens/live_home_screen.dart';

import '../utils/assets_colors_path.dart';
import '../utils/constants.dart';
import '../widgets/customise_button.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  late Color _buttonColor = AssetsColorsPath.buttonShadowColors;
  bool _isChecked = false;
  bool _isPasswordIcon = false;

  @override
  void initState() {
    super.initState();
    _emailTEController.addListener(_upDateButtonColor);
    _passwordTEController.addListener(_upDateButtonColor);
  }

  void dataLogIn() {
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailTEController.text.trim(),
      password: _passwordTEController.text,
    );
  }


  void _iconCheckbox() {
    setState(() {
      _isChecked = !_isChecked;
    });
  }

  void _passwordCheckBox() {
    setState(() {
      _isPasswordIcon = !_isPasswordIcon;
    });
  }

  void _upDateButtonColor() {
    setState(() {
      if (_emailTEController.text.isNotEmpty &&
          _passwordTEController.text.isNotEmpty) {
        _buttonColor = AssetsColorsPath.buttonColors;
      } else {
        _buttonColor = AssetsColorsPath.buttonShadowColors;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body:GetBuilder<LoginController>(
        builder: (ctrl) {
          return Visibility(
            visible: !ctrl.inProgress,
            replacement: Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.grey,
                size: 50,
              ),
            ),
            child: SingleChildScrollView(
                    child: Form(
                      key: _fromKey,
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Inter your Email address and password',
                              style: textTheme.titleLarge,
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            Text(
                              'Email',
                              style: textTheme.labelMedium,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              controller: _emailTEController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                hintText: 'Input Email',
                                prefixIcon: Icon(Icons.mail_outlined),
                              ),
                              validator: (String? values) {
                                if (values?.isEmpty ?? true) {
                                  return 'Enter your Email Adders';
                                }
                                if (Constants.regExpEmailVerification
                                        .hasMatch(values ?? '') ==
                                    false) {
                                  return 'Enter your valid Email Adders';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Password',
                              style: textTheme.labelMedium,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              controller: _passwordTEController,
                              obscureText: !_isPasswordIcon,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: 'Input Password',
                                prefixIcon: const Icon(Icons.lock_outline_sharp),
                                suffixIcon: InkWell(
                                  onTap: _passwordCheckBox,
                                  child: Icon(_isPasswordIcon
                                      ? Icons.remove_red_eye
                                      : Icons.remove_red_eye_outlined),
                                ),
                              ),
                              validator: (String? value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Enter your Password';
                                }
                                if (value!.length < 8) {
                                  return 'Password must be at least 8 characters';
                                }
                                if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
                                  return 'Password must contain at least one uppercase letter';
                                }
                                if (!RegExp(r'^(?=.*[a-z])').hasMatch(value)) {
                                  return 'Password must contain at least one lowercase letter';
                                }
                                if (!RegExp(r'^(?=.*\d)').hasMatch(value)) {
                                  return 'Password must contain at least one number';
                                }
                                if (!RegExp(r'^(?=.*[@$!%*?&])').hasMatch(value)) {
                                  return 'Password must contain at least one special character (@, \$, etc.)';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // Row(
                            //   children: [
                            //     IconButton(
                            //       onPressed: _iconCheckbox,
                            //       icon: Icon(
                            //         _isChecked
                            //             ? Icons.check_box
                            //             : Icons.check_box_outline_blank_rounded,
                            //       ),
                            //     ),
                            //     Text(
                            //       'Save Password',
                            //       style: textTheme.titleMedium,
                            //     ),
                            //   ],
                            // ),
                            const SizedBox(
                              height: 25,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: CustomiseButton(
                                title: 'Log In',
                                onTap: ()async{
                                  bool isSuccess=await Get.find<LoginController>().login(
                                    email: _emailTEController.text.trim(),
                                    password: _passwordTEController.text.trim(),
                                  );
                                  if(isSuccess){
                                    Get.to(()=>const InitialScreen());
                                  }
                                },
                                color: _buttonColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          );
        }
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
  }
}
