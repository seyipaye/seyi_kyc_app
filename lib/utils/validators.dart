import 'package:get/utils.dart';
import 'package:seyi_kyc_app/constant.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class Validator {
  static String isName(String value) {
    if (value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String isEmail(String value) {
    if (value.isEmpty) {
      return 'This field is required';
    } else if (!GetUtils.isEmail(value.trim())) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String Function(String) isPassword = Validators.compose([
    Validators.required(
      'Input Password}',
    ),
    Validators.minLength(
      8,
      'Minimum of 8 characters required for Password}',
    ),
    Validators.patternRegExp(
      kOneLowerCaseRegex,
      'Password should contain at least a Lowercase letter',
    ),
    Validators.patternRegExp(
      kOneNumberRegex,
      'Password should contain at least a number',
    ),
    Validators.patternRegExp(
      kOneSpecialCharRegex,
      'Special Character eg.(\$\%#&@)',
    )
  ]);

  static String isAddress(String value) {
    if (value.isEmpty) {
      return 'This field is required';
    } else if (!GetUtils.isLengthGreaterThan(value, 4)) {
      return 'Please enter a valid Address';
    }
    return null;
  }

  static String isNotEmpty(String value) {
    if (value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String isInviteCode(String value) {
    if (value.isNotEmpty && value.length != 6) {
      return 'Invite code must be six characters long';
    }

    return null;
  }

  static String isPromoCode(String value) {
    if (value.isEmpty || value.length != 6) {
      return 'Promo code must be six characters long';
    }

    return null;
  }
}
