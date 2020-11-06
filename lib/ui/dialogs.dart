import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:seyi_kyc_app/styles.dart';
import 'package:seyi_kyc_app/ui/widgets/app_raised_button.dart';
import 'package:seyi_kyc_app/utils/validators.dart';

import 'widgets/app_text_form_field.dart';

class PassportDialog extends StatefulWidget {
  const PassportDialog({
    Key key,
  }) : super(key: key);

  @override
  _PassportDialogState createState() => _PassportDialogState();
}

class _PassportDialogState extends State<PassportDialog> {
  DateTime _selectedDate;
  TextEditingController _dobController;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _dobController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)), //this right here
      child: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Passport verification',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColor.darkBlue),
                ),
                SizedBox(height: 15),
                Text(
                  'Upload passport and proof of address to continue',
                  style: TextStyle(fontSize: 16, color: AppColor.darkBlue),
                ),
                SizedBox(height: 40),
                DottedBorder(
                  color: AppColor.text2,
                  dashPattern: [5, 5],
                  strokeWidth: 1,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 50),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/image.svg',
                            height: 50,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Click to upload passport',
                            style: TextStyle(
                                fontSize: 16, color: AppColor.darkBlue),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                DottedBorder(
                  color: AppColor.text2,
                  dashPattern: [5, 5],
                  strokeWidth: 1,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 50),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/certificate.svg',
                            height: 50,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Click to upload utility bill',
                            style: TextStyle(
                                fontSize: 16, color: AppColor.darkBlue),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                AppRaisedButton(
                  text: 'Confirm',
                  onPressed: () {},
                  backgroundColor: AppColor.weirdGreen,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BVNDialog extends StatefulWidget {
  const BVNDialog({
    Key key,
  }) : super(key: key);

  @override
  _BVNDialogState createState() => _BVNDialogState();
}

class _BVNDialogState extends State<BVNDialog> {
  DateTime _selectedDate;
  TextEditingController _dobController;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _dobController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)), //this right here
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'BVN verification',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.darkBlue),
              ),
              SizedBox(height: 40),
              AppTextFormField(
                label: 'Bvn Number',
                //onSaved: (String val) => _newUser.email = val,
                validator: Validator.isNotEmpty,
              ),
              SizedBox(height: 30),
              AppTextFormField(
                  label: 'Date of birth',
                  readOnly: true,
                  controller: _dobController,
                  validator: Validator.isNotEmpty,
                  suffixIcon: Icon(Icons.calendar_today),
                  onTap: () async {
                    final DateTime datePicked = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: _selectedDate.add(Duration(days: -20)),
                      lastDate: _selectedDate.add(Duration(days: 365)),
                    );

                    if (datePicked != null) {
                      _dobController.text =
                          DateFormat('dd-MM-yyyy').format(_selectedDate);
                      _selectedDate = datePicked;
                    }
                  }),
              SizedBox(height: 30),
              AppRaisedButton(
                text: 'Confirm',
                onPressed: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return new AlertDialog(
                          title: Text('Enter your OTP'),
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(30),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          contentPadding: EdgeInsets.all(10.0),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Submit',
                              ),
                            ),
                          ],
                        );
                      });
                },
                backgroundColor: AppColor.weirdGreen,
              )
            ],
          ),
        ),
      ),
    );
  }
}
