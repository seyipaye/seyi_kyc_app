import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:seyi_kyc_app/models/app_state.dart';
import 'package:seyi_kyc_app/ui/screens/home_screen.dart';
import 'package:seyi_kyc_app/utils/AppSnackBar.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future _initialization;

  @override
  void initState() {
    super.initState();
    _initialization = Firebase.initializeApp().then(
      (_) => WidgetsBinding.instance.addPostFrameCallback(
        (_) => Provider.of<AppState>(context, listen: false)
            .initializeUser(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              print(snapshot.error);
              WidgetsBinding.instance.addPostFrameCallback(
                (_) => Scaffold.of(context).showSnackBar(
                  AppSnackBar.error(snapshot.error.toString()),
                ),
              );
            }

            // Check if user is signed in
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data != null) {
              WidgetsBinding.instance.addPostFrameCallback(
                (_) => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => HomeScreen()),
                ),
              );
            }

            return Container(
              color: Color(0xFF2699EF),
              child: Center(
                child: SvgPicture.asset(
                  "assets/icons/white_logo.svg",
                ),
              ),
            );
          }),
    );
  }
}
