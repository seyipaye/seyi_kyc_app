import 'package:flutter/material.dart';

import '../../constant.dart';
import '../../styles.dart';

enum AppButton {
  PLAIN,
  APPLE,
  GOOGLE,
  OTP,
}

class LoadingIndicator {
  final bool isLoading;
  final AppButton button;

  const LoadingIndicator({this.isLoading = false, this.button});
}

class AppRaisedButton extends StatelessWidget {
  const AppRaisedButton(
      {this.onPressed,
      this.text,
      this.textColor = Colors.white,
      this.backgroundColor,
      this.height,
      this.isLoading = false,
      this.prefixIcon,
      this.fontSize,
      this.elevation});

  final Function onPressed;
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final Widget prefixIcon;

  /// The [Height] is 50.0 by default
  final double height;

  /// The [FontSize] is 16.0 by default
  final double fontSize;

  final bool isLoading;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    final Text content = Text(
      text ?? '',
    );
    return MaterialButton(
      height: height ?? 50,
      elevation: elevation ?? 2,
      minWidth: double.infinity,
      onPressed: isLoading ? () {} : onPressed,
      color: backgroundColor ?? AppColor.primaryColor,
      textColor: textColor,
      shape: kRoundedRectangleBorder,
      child: isLoading
          ? ButtonLoadingIndicator(
              color: textColor,
              radius: 15,
            )
          : prefixIcon == null
              ? content
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: prefixIcon,
                    ),
                    content
                  ],
                ),
    );
  }
}

class ButtonLoadingIndicator extends StatelessWidget {
  ButtonLoadingIndicator({
    Key key,
    this.color,
    double radius,
  }) : super(key: key) {
    if (radius != null) {
      this.height = radius;
      this.width = radius;
    }
  }

  final Color color;
  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: CircularProgressIndicator(
        // backgroundColor: Colors.black,
        valueColor: AlwaysStoppedAnimation(color),
        strokeWidth: 1.8,
      ),
    );
  }
}
