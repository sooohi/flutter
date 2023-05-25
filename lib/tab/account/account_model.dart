import 'package:firebase_auth/firebase_auth.dart';

class AccountModel{
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();

  }
}