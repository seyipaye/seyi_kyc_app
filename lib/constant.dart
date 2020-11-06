import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:seyi_kyc_app/styles.dart';

class Constants {}

final kOneLowerCaseRegex = RegExp(r'^(?=.*?[a-z]).{8,}$');
final kOneSpecialCharRegex = RegExp(r'^(?=.*?[!@#_^\$&*~]).{8,}$');
final kOneNumberRegex = RegExp(r'^(?=.*?[0-9]).{8,}$');

BoxDecoration kLightRing = BoxDecoration(
  borderRadius: BorderRadius.circular(5),
  border: Border.all(
    color: AppColor.stroke,
    width: 1,
  ),
);

double kLineHeight({double fontSize, double height}) => height / fontSize;

TextStyle kInputTextStyle(context) => Theme.of(context)
    .textTheme
    .bodyText2
    .copyWith(fontWeight: FontWeight.w300, fontSize: 16);

final kAnimationDuration = Duration(milliseconds: 300);

BoxShadow kDropShadow(double dx, double dy, double blurRadius,
        {color = AppColor.offset}) =>
    BoxShadow(
      offset: Offset(dx, dy),
      blurRadius: blurRadius,
      color: color,
    );

final kRoundedRectangleBorder = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(5),
);

final kRoundedTopRectangleBorder = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(34),
    topRight: Radius.circular(34),
  ),
);

final kBoxShadow = <BoxShadow>[
  BoxShadow(
    offset: Offset(0, 16),
    blurRadius: 16,
    color: Colors.black26,
  )
];
