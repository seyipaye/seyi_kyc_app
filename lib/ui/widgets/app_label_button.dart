import 'package:flutter/material.dart';
import 'package:seyi_kyc_app/styles.dart';

import '../../constant.dart';

class AppLabelButton extends StatelessWidget {
  static const defaultTextStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w300);

  const AppLabelButton({
    this.onPressed,
    this.text,
    this.textColor = AppColor.primaryColor,
    this.prefixIcon,
    this.textStyle = defaultTextStyle,
  });

  final VoidCallback onPressed;
  final String text;
  final TextStyle textStyle;
  final Color textColor;
  final Widget prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlatButton(
        onPressed: onPressed,
        textColor: textColor,
        child: prefixIcon == null
            ? Text(
                text,
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: prefixIcon,
                  ),
                  Text(
                    text,
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        fontWeight: FontWeight.w300),
                  )
                ],
              ),
      ),
    );
  }
}
