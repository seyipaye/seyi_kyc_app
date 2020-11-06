import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:seyi_kyc_app/models/app_state.dart';
import 'package:seyi_kyc_app/styles.dart';
import 'package:seyi_kyc_app/ui/screens/signup_screen.dart';
import 'package:seyi_kyc_app/ui/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          //systemNavigationBarIconBrightness: Brightness.dark,
          //statusBarColor: Colors.transparent,
          //systemNavigationBarColor: Colors.black,
          //systemNavigationBarDividerColor: Colors.black,
          ),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppState(),
        ),
      ],
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              appBarTheme: AppBarTheme(
                color: Colors.white,
                iconTheme: IconThemeData(color: Colors.black),
                actionsIconTheme: IconThemeData(color: Colors.black),
                textTheme: TextTheme(
                  headline6: Typography.blackCupertino.headline6
                      .copyWith(fontSize: 17, fontWeight: FontWeight.w600),
                ),
                elevation: 1,
                brightness: Brightness.light, // status bar brightness
              ),
              primarySwatch: AppColor.primaryColor,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              scaffoldBackgroundColor: AppColor.background,
              textTheme: Typography.blackCupertino,
              inputDecorationTheme: InputDecorationTheme(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: AppColor.stroke, width: 1),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.red.shade900, width: 0.5),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.red.shade900, width: 0.5),
                  borderRadius: BorderRadius.circular(5),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 10),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide:
                      BorderSide(color: AppColor.primaryColor, width: 1),
                ),
              )),
          home: SplashScreen(),
        );
      },
    );
  }
}
