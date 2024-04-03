
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, Object e) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$e")));
}

Future<void> createAccount({
  required String email,
  required String password,
}) async {
  await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email!,
    password: password!,
  );
}
