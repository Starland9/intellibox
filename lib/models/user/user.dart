import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  final String username;
  final String email;
  final String? image;
  final String? locale;

  factory AppUser.fromGoogle(UserCredential googleUser) {
    return AppUser(
      googleUser.user!.displayName!,
      googleUser.user!.email!,
      googleUser.user?.photoURL,
      googleUser.additionalUserInfo?.profile?['locale'],
    );
  }

  AppUser(this.username, this.email, this.image, this.locale);
}
