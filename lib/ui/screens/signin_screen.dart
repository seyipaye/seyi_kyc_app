import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:seyi_kyc_app/models/user.dart';
import 'package:seyi_kyc_app/repositories/auth_repository.dart';
import 'package:seyi_kyc_app/ui/widgets/app_label_button.dart';
import 'package:seyi_kyc_app/ui/widgets/app_raised_button.dart';
import 'package:seyi_kyc_app/ui/widgets/app_text_form_field.dart';
import 'package:seyi_kyc_app/utils/AppSnackBar.dart';
import 'package:seyi_kyc_app/utils/validators.dart';

import 'home_screen.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final User _newUser = User();
  final _repository = AuthRepository();

  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  bool hidePassword = true;
  bool isLoading = false;

  Future<void> signInHandler(context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      FocusScope.of(context).unfocus();
      setState(() => isLoading = true);
      String error = await _repository.loginUser(_newUser, context);
      setState(() => isLoading = false);

      if (error == null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (Route<dynamic> route) => false);
      } else {
        Scaffold.of(context).showSnackBar(AppSnackBar.error(error));
      }
    } else {
      setState(() => _autoValidateMode = AutovalidateMode.always);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/blue_logo.svg",
                  height: 60,
                ),
                SizedBox(width: 20),
                Text(
                  'HACKATHON',
                  style: Theme.of(context).textTheme.headline4,
                )
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Welcome Back',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 10),
            Text(
              'Please sign in',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(height: 40),
            Builder(
              builder: (context) => _buildForm(context),
            )
          ],
        ),
      ),
    );
  }

  Form _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: _autoValidateMode,
      child: Column(
        children: [
          AppTextFormField(
            label: 'Email Address',
            hintText: 'Email Address',
            onSaved: (String val) => _newUser.email = val,
            validator: Validator.isEmail,
          ),
          SizedBox(
            height: 30.0,
          ),
          AppTextFormField(
            label: 'Password',
            readOnly: false,
            obscureText: hidePassword,
            onSaved: (String val) => _newUser.password = val,
            validator: Validator.isPassword,
            suffixIcon: IconButton(
              icon: hidePassword
                  ? Icon(Icons.visibility_off)
                  : Icon(Icons.remove_red_eye),
              onPressed: () {
                setState(() => hidePassword = !hidePassword);
              },
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          //  Button
          AppRaisedButton(
            text: 'Sign in',
            isLoading: isLoading,
            onPressed: () => signInHandler(context),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'New user ?',
                style: AppLabelButton.defaultTextStyle,
              ),
              AppLabelButton(
                text: 'Sign up',
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          AppLabelButton(
            text: 'Forgot Password ?',
            onPressed: () {},
          ),
          SizedBox(
            height: 30.0,
          ),
        ],
      ),
    );
  }
}
