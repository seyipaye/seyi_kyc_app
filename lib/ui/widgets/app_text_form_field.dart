import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constant.dart';
import '../../styles.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField(
      {this.autofocus = false,
      this.readOnly = false,
      this.onChanged,
      this.initialValue,
      this.label,
      this.hintText,
      this.keyboardType,
      this.obscureText = false,
      this.controller,
      this.validator,
      this.helperText,
      this.height,
      this.hintColor,
      this.borderWidth,
      this.onTap,
      this.onSaved,
      this.focusNode,
      this.textInputAction,
      this.onFieldSubmitted,
      this.suffixIcon,
      this.prefixIcon,
      this.autovalidate = false,
      this.maxLines = 1,
      this.inputFormatters,
      this.errorText,
      Key key})
      : super(key: key);

  final int maxLines;
  final String hintText;
  final String errorText;
  final TextInputType keyboardType;
  final bool obscureText;
  final String helperText;
  final Color hintColor;
  final TextEditingController controller;
  final double borderWidth;
  final double height;
  final Function(String) validator;
  final Function onSaved;
  final Function onTap;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final Function onFieldSubmitted;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final String label;
  final String initialValue;
  final Function onChanged;
  final bool readOnly;
  final bool autofocus;
  final bool autovalidate;
  final List<TextInputFormatter> inputFormatters;

  @override
  Widget build(BuildContext context) {
    Widget textFormField = TextFormField(
      readOnly: readOnly,
      autovalidate: autovalidate,
      onChanged: onChanged,
      initialValue: initialValue,
      obscureText: obscureText,
      textAlignVertical: TextAlignVertical.center,
      keyboardType: keyboardType,
      controller: controller != null ? controller : null,
      focusNode: focusNode,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      autofocus: autofocus,
      maxLines: maxLines,
      inputFormatters: inputFormatters,
      style: kInputTextStyle(context),
      validator: validator,
      onSaved: onSaved,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: hintText,
        helperMaxLines: 2,
        errorMaxLines: 2,
        errorText: errorText,
        hintStyle: TextStyle(fontWeight: FontWeight.w300),
        helperText: helperText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
    );

    return label == null
        ? textFormField
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColor.label,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              textFormField
            ],
          );
  }
}
