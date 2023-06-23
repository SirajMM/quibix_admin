import 'dart:developer';

import 'package:admin/presentation/home/home_screen.dart';
import 'package:flutter/material.dart';
import '../../../domain/models/auth.dart';
import '../../login_screen/login_screen.dart';

class LoginOrSignIn extends StatelessWidget {
  const LoginOrSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        log(snapshot.data.toString());
        if (snapshot.hasData) {
          return const ScreenHome();
        } else {
          return const ScreenLogin();
        }
      },
    );
  }
}
