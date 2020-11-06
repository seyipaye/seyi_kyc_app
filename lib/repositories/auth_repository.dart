import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:seyi_kyc_app/models/app_state.dart';
import 'package:seyi_kyc_app/models/user.dart';

class AuthRepository {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');
  final DocumentReference _invitationPromoDoc =
      FirebaseFirestore.instance.collection('promotions').doc('invitation');
  final DocumentReference _welcomePromoDoc =
      FirebaseFirestore.instance.collection('promotions').doc('welcome');
  final String codesPath = 'codes';

  auth.FirebaseAuth firebaseAuth = auth.FirebaseAuth.instance;

  Future<String> loginUser(User user, BuildContext context) async {
    try {
      // Create Firebase user
      await firebaseAuth.signInWithEmailAndPassword(
          email: user.email, password: user.password);

      // Fetch user data afresh for consumption by the whole app
      Provider.of<AppState>(context, listen: false).initializeUser();

      print("Login User: ${user.toMap()}");
    } on auth.FirebaseAuthException catch (e) {
      print(e);
      return e.message;
    } catch (e) {
      print(e);
      return 'Error: $e, Please try again later';
    }

    return null;
  }

  Future<String> createUser(User user, BuildContext context) async {
    try {
      // Create Firebase user
      auth.UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: user.email, password: user.password);
      userCredential.user.updateProfile(displayName: user.uName);
      user.uid = userCredential.user.uid;

      await userCredential.user.sendEmailVerification();

      // Upload user data
      await _users.doc(user.uid).set(user.toMap());

      // Fetch user data afresh for consumption by the whole app
      await Provider.of<AppState>(context, listen: false).initializeUser();

      print("Created User: $user");
    } on auth.FirebaseAuthException catch (e) {
      print(e);
      return e.message;
    } catch (e) {
      print(e);
      return 'Error: $e, Please try again later';
    }

    return null;
  }

  Stream<User> getUser(String uid) => _users.doc(uid).snapshots().map(
        (event) => User.fromMap(
          event.data(),
        ),
      );

  /* Future<String> setUpUser(User user, BuildContext context,
      {String code}) async {
    try {
      user.inviteCode =
          await _handlePromotions(uid: user.uid, referrerInviteCode: code);

      // Upload user data
      await _users.doc(user.uid).update(user.toJson());

      print("Set up User: ${user.toString()}");
    } catch (e) {
      print(e);
      return 'Error: $e try again later';
    }

    return null;
  }
*/
  Future<String> sendPasswordResetLink(String email) async {
    try {
      // Send reset link
      await firebaseAuth.sendPasswordResetEmail(email: email);

      print("Sent reset link to $email");
    } on auth.FirebaseAuthException catch (e) {
      print(e);
      return e.message;
    } catch (e) {
      print(e);
      return 'Error: $e, Please try again later';
    }

    return null;
  }
}
