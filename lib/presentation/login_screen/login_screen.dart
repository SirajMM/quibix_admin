// ignore_for_file: unnecessary_null_comparison

import 'package:admin/presentation/login_screen/reset_password/reset_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants/colors/app_color.dart';
import '../../constants/constants.dart';
import '../../domain/models/auth.dart';
import 'widgets/log_in_elevated_button.dart';
import 'widgets/text_field.dart';

// ignore: must_be_immutable
class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  String errorMessage = '';

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _paswordController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _emailController.text,
        password: _paswordController.text,
      );
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message!;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // User? user = FirebaseAuth.instance.currentUser;
    final respSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: _key,
        child: Container(
          height: respSize.height,
          width: respSize.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                AppConstantsColor.materialThemeColor2,
                AppConstantsColor.materialThemeColor,
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  SizedBox(
                    height: respSize.height * 0.15,
                  ),
                  const Text(
                    'Sign In',
                    style: TextStyle(
                        color: AppConstantsColor.lightTextColor,
                        fontSize: 50,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: respSize.height * 0.02,
                  ),
                  const Text(
                    'Email',
                    style: TextStyle(
                        color: AppConstantsColor.lightTextColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w200),
                  ),
                  constSizedBox10,
                  CustomTextField(
                      comtroller: _emailController, validator: validateEmail),
                  SizedBox(
                    height: respSize.height * 0.02,
                  ),
                  const Text(
                    'Password',
                    style: TextStyle(
                        color: AppConstantsColor.lightTextColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w200),
                  ),
                  constSizedBox10,
                  CustomTextField(
                      comtroller: _paswordController,
                      validator: validatePassword),
                  constSizedBox10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResetScreen(),
                            )),
                        child: const Text(
                          'Forget Password?',
                          style: TextStyle(
                              color: AppConstantsColor.lightTextColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w200),
                        ),
                      )
                    ],
                  ),
                  Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                  SizedBox(
                    height: respSize.height * 0.06,
                  ),
                  LogInElevatodButton(
                    onTap: () {
                      if (_key.currentState!.validate()) {}
                      signInWithEmailAndPassword();
                    },
                    text: 'Log In',
                  ),
                  constSizedBox10,
                ],
              ),
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}

String? validateEmail(String? formEmail) {
  if (formEmail!.isEmpty || formEmail == null) {
    return 'E-mail address is required.';
  }
  String pattern = r'\w+@\w+\.\w+';
  RegExp regexp = RegExp(pattern);
  if (!regexp.hasMatch(formEmail)) return 'Invalid E-mail Address';

  return null;
}

String? validatePassword(String? formPassword) {
  if (formPassword!.isEmpty || formPassword == null) {
    return 'password is required.';
  }

  return null;
}
