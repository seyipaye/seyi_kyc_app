import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:seyi_kyc_app/models/user.dart';
import 'package:seyi_kyc_app/repositories/auth_repository.dart';
import 'package:seyi_kyc_app/ui/screens/signup_screen.dart';

class AppState extends ChangeNotifier {
  auth.FirebaseAuth _firebaseAuth;
  User user = User();

  Future initializeUser([BuildContext context]) {
    _firebaseAuth = auth.FirebaseAuth.instance;

    // Get local user data first
    auth.User localUser = _firebaseAuth.currentUser;

    if (localUser == null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => SignUpScreen()),
      );
      return null;
    } else {
      this.user = User.fromFirebaseUser(localUser);

      final _userStream = AuthRepository().getUser(user.uid);

      _userStream.listen((event) {
        this.user = event;
        print("Got User: ${event.toMap()})");
        notifyListeners();
      }, onDone: () {
        print('Done');
      });
      _userStream.handleError((e) {
        print('Error: $e');
      });

      return Future.value('Success');
    }
  }
}
