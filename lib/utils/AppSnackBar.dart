import 'package:flutter/material.dart';

import '../styles.dart';

class AppSnackBar {
  static SnackBar error(String _message) {
    return SnackBar(
      content: Text(_message),
      backgroundColor: Colors.red,
    );
  }

  static SnackBar neutral(String _message) {
    return SnackBar(
      content: Text(
        _message,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: AppColor.subtitle,
    );
  }

  static SnackBar success(String _message) {
    return SnackBar(
      content: Text(_message),
      backgroundColor: Colors.lightGreen,
    );
  }
}
