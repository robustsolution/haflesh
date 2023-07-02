// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_hafleh/core/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:crypto/crypto.dart';

/// Generates a cryptographically secure random nonce, to be included in a
/// credential request.
String generateNonce([int length = 32]) {
  // ignore: prefer_const_declarations
  final charset =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  final random = Random.secure();
  return List.generate(length, (_) => charset[random.nextInt(charset.length)])
      .join();
}

/// Returns the sha256 hash of [input] in hex notation.
String sha256ofString(String input) {
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}

class AuthRepository {
  final supabase = Supabase.instance.client;
  String _verificationId = "";
  bool codeSent = false;

  Future<void> signInWithPhone(String phoneNumber) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      codeSent = false;
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto sign-in on Android devices.
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }
          // ...
        },
        codeSent: (String verificationId, int? resendToken) async {
          // Save the verification ID somewhere so that you can use it later.
          _verificationId = verificationId;
          codeSent = true;
          print("_verificationId $verificationId");
        },
        timeout: const Duration(seconds: 120),
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-resolution timed out...
        },
      );
      print("phone signin $phoneNumber");
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  Future<UserModel> verifyOTP(String smsCode) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: smsCode);

      // Sign the user in (or link) with the credential
      await auth.signInWithCredential(credential);
      return await createOrFindUser();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  bool isLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }

  Future<UserModel> createOrFindUser() async {
    User? authedUser = FirebaseAuth.instance.currentUser;
    try {
      final existing = await supabase
          .from('users')
          .select<Map<String, dynamic>>()
          .eq('uid', authedUser!.uid)
          .single();
      if (existing.isNotEmpty) {
        return UserModel.fromJson(existing);
      }
    } catch (e) {
      // not existing need to create
    }

    UserModel user = UserModel(
        uid: authedUser!.uid,
        email: authedUser.email,
        phoneNumber: authedUser.phoneNumber,
        provider: authedUser.providerData[0].providerId,
        isDisabled: false);

    try {
      await supabase.from('users').insert(user.toJson());
    } catch (e) {
      throw Exception('supabase connection problem');
    }

    return user;
  }
}
