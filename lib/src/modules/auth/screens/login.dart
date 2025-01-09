// ignore_for_file: prefer_const_constructors

import 'package:animate_do/animate_do.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intellibox_v2/src/modules/auth/services/auth.dart';
import 'package:intellibox_v2/src/modules/home/screens/home.dart';
import 'package:intellibox_v2/src/utils/assets.dart';
import 'package:intellibox_v2/src/utils/logic.dart';
import 'package:intellibox_v2/src/utils/theme.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FadeInDown(
              child: Image.asset(
                SImages.appLogo,
                width: 250,
              ),
            ),
            FadeIn(
              delay: Duration(seconds: 1),
              child: Column(
                children: [
                  Text(
                    "IntelliBox",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Scolors.primary,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Ta boite à outils intelligente !"),
                ],
              ),
            ),
            FadeInUp(
              child: Column(
                children: [
                  GoogleAuthButton(
                    onPressed: () async {
                      await Auth.signInWithGoogle().then((value) {
                        if (value.user != null) {
                          Nav.pushR(context, HomePage());
                        } else {
                          AwesomeDialog(
                            context: context,
                            desc: "Un problème est survenu brusquement 😢",
                          );
                        }
                      });
                    },
                    text: "Connexion avec Google",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
