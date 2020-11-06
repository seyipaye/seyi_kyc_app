import 'package:firebase_auth/firebase_auth.dart' as auth;

class User {
  String uid;
  String name;
  String uName;
  String email;
  String password;
  bool isVerified;
  int kycLevel;

  User({
    this.uid,
    this.name,
    this.uName,
    this.email,
    this.password,
    this.isVerified,
    this.kycLevel,
  });

  User.fromSignUp() {
    this.isVerified = false;
    this.kycLevel = 0;
  }

  factory User.fromFirebaseUser(auth.User localUser) {
    return User(
      uid: localUser.uid,
      uName: localUser.displayName,
      email: localUser.email,
    );
  }

  factory User.fromMap(dynamic map) {
    if (null == map) return null;
    var temp;
    return User(
      uid: map['uid']?.toString(),
      name: map['name']?.toString(),
      uName: map['uName']?.toString(),
      email: map['email']?.toString(),
      password: map['password']?.toString(),
      isVerified: null == (temp = map['isVerified'])
          ? null
          : (temp is bool ? temp : bool.fromEnvironment(temp)),
      kycLevel: null == (temp = map['kycLevel'])
          ? null
          : (temp is num ? temp.toInt() : int.tryParse(temp)),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'uName': uName,
      'email': email,
      'password': password,
      'isVerified': isVerified,
      'kycLevel': kycLevel,
    };
  }
}
