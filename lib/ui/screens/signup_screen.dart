import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:seyi_kyc_app/models/user.dart';
import 'package:seyi_kyc_app/repositories/auth_repository.dart';
import 'package:seyi_kyc_app/ui/screens/signin_screen.dart';
import 'package:seyi_kyc_app/ui/widgets/app_label_button.dart';
import 'package:seyi_kyc_app/ui/widgets/app_raised_button.dart';
import 'package:seyi_kyc_app/ui/widgets/app_text_form_field.dart';
import 'package:seyi_kyc_app/utils/AppSnackBar.dart';
import 'package:seyi_kyc_app/utils/validators.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _repository = AuthRepository();
  final User _newUser = User.fromSignUp();

  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  bool hidePassword = true;
  bool isLoading = false;

  Future<void> handleSignUp(context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      //print(_newUser);
      FocusScope.of(context).unfocus();
      setState(() => isLoading = true);
      String error = await _repository.createUser(_newUser, context);
      setState(() => isLoading = false);

      if (error == null) {
        print('Success');
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(
        //     builder: (_) => HomeScreen(),
        //   ),
        // );
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
              'Create your hackathon account',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 30),
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
            label: 'Name',
            hintText: 'Name',
            onSaved: (String val) => _newUser.name = val,
            validator: Validator.isName,
          ),
          SizedBox(
            height: 30.0,
          ),
          AppTextFormField(
            label: 'Username',
            hintText: 'Username',
            onSaved: (String val) => _newUser.uName = val,
            validator: Validator.isName,
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
            helperText: 'Use 8 or more characters with a mix of letters,'
                'numbers & symbols',
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
          // AppTextFormField(
          //   label: 'Confirm Password',
          //   readOnly: false,
          //   obscureText: hidePassword,
          //   //onSaved: (String val) => _newUser.password = val,
          //   validator: Validator.isPassword,
          //   suffixIcon: IconButton(
          //     icon: hidePassword
          //         ? Icon(Icons.visibility_off)
          //         : Icon(Icons.remove_red_eye),
          //     onPressed: () {
          //       setState(() => hidePassword = !hidePassword);
          //     },
          //   ),
          // ),
          // SizedBox(
          //   height: 30.0,
          // ),
          //  Button
          AppRaisedButton(
            text: 'Sign up',
            isLoading: isLoading,
            onPressed: () => handleSignUp(context),
          ),
          SizedBox(
            height: 10.0,
          ),
          AppLabelButton(
            text: 'Sign in instead ?',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => SignInScreen(),
                ),
              );
            },
          ),
          SizedBox(
            height: 30.0,
          ),
        ],
      ),
    );
  }
}
