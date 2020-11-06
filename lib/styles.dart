import 'package:flutter/material.dart';

class AppColor {
  /// Same as #80135A59
  static const weirdGreen = Color(0xFF48D3CE);

  /// Same as #135a59 10%
  static const paleGreen = Color(0x19135a59);

  /// Same as #151522
  static const label = Color(0xFF151522);

  /// Same as #999999
  static const text2 = Color(0xFF999999);

  /// 787676
  static const subtitle = Color(0xFF787676);

  static const divider = Color(0x33E4E4E4);

  /// Same as #99E4E4E4 0r rgba(228, 228, 228, 0.6)
  static const stroke = Color(0x99E4E4E4);

  static const background = Color(0xFFFAFAFA);

  /// Same as rgba(50, 50, 71, 0.08)
  static const offset = Color(0x14323247);

  /// 151522
  static const neutralBlack = Color(0xFF151522);

  /// 151522
  static const darkBlue = Color(0xFF364C71);

  static const primaryColor = MaterialColor(
    _primaryValue,
    <int, Color>{
      50: Color(0xFFe7f4fd),
      100: Color(0xFFb8defa),
      200: Color(0xFF88c7f6),
      300: Color(0xFF59b1f3),
      400: Color(0xFF299bef),
      500: Color(_primaryValue),
      600: Color(0xFF0c64a6),
      700: Color(0xFF094877),
      800: Color(0xFF052b47),
      900: Color(0xFF020e18),
    },
  );
  static const int _primaryValue = 0xFF2699EF;
}
