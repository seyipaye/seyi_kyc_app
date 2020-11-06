import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:seyi_kyc_app/models/app_state.dart';
import 'package:seyi_kyc_app/models/user.dart';
import 'package:seyi_kyc_app/styles.dart';
import 'package:seyi_kyc_app/ui/dialogs.dart';
import 'package:seyi_kyc_app/ui/widgets/app_raised_button.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

const horizontalPadding = 30.0;

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  List<Widget> selectableChildren = [
    _buildSelectableChild(
        assetName: 'assets/icons/bank.svg',
        title: 'Level 1',
        subtitle: 'BVN Verification'),
    _buildSelectableChild(
        assetName: 'assets/icons/pass.svg',
        title: 'Level 2',
        subtitle: 'Passport Verification'),
    _buildSelectableChild(
        assetName: 'assets/icons/link.svg',
        title: 'Level 3',
        subtitle: 'Link Bank Account'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: horizontalPadding),
      child: Consumer<AppState>(builder: (_, appState, child) {
        User _user = appState.user;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildHeader(_user),
            SizedBox(height: 30),
            _buildBody(_user),
            Padding(
              padding: const EdgeInsets.all(horizontalPadding),
              child: AppRaisedButton(
                text: 'Continue Verification',
                backgroundColor: AppColor.weirdGreen,
                onPressed: () {
                  switch (_user.kycLevel) {
                    case 0:
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return BVNDialog();
                          });
                      break;
                    case 1:
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return PassportDialog();
                          });
                      break;
                    default:
                      print('finish');
                  }
                },
              ),
            )
          ],
        );
      }),
    );
  }

  Container _buildBody(User user) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontalPadding),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: AppColor.stroke,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Verification',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColor.darkBlue),
          ),
          SizedBox(height: 15),
          Text(
            'Complete steps below to get verified',
            style: TextStyle(fontSize: 16, color: AppColor.darkBlue),
          ),
          SizedBox(height: 15),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: selectableChildren.length,
            itemBuilder: (_, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SelectableContainer(
                child: selectableChildren[index],
                isSelected: user.kycLevel > index,
              ),
            ),
          )
        ],
      ),
    );
  }
}

Container _buildHeader(User user) {
  return Container(
    color: Colors.white,
    padding: EdgeInsets.symmetric(vertical: 15, horizontal: horizontalPadding),
    child: Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.account_circle_rounded,
              color: AppColor.stroke,
              size: 100,
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColor.darkBlue),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  user.email,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColor.darkBlue),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'KYC LV ${user.kycLevel}',
                  style: TextStyle(
                      fontSize: 16,
                      color: AppColor.darkBlue,
                      fontWeight: FontWeight.w400),
                ),
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: AppColor.darkBlue,
                      width: 1,
                      style: BorderStyle.solid),
                ),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                'Upgrade to level ${user.kycLevel + 1}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.weirdGreen,
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
        )
      ],
    ),
  );
}

Widget _buildSelectableChild({String assetName, title, subtitle}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      SvgPicture.asset(
        assetName,
        height: 80,
      ),
      DefaultTextStyle(
        style: TextStyle(color: AppColor.darkBlue, fontSize: 16),
        child: Column(
          children: [Text(title), SizedBox(height: 5), Text(subtitle)],
        ),
      )
    ],
  );
}

class SelectableContainer extends StatelessWidget {
  final bool isSelected;
  final Widget child;

  const SelectableContainer({Key key, this.isSelected = false, this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          color: AppColor.background,
          child: child,
        ),
        isSelected ? _buildOverlay() : SizedBox.shrink(),
      ],
    );
  }

  _buildOverlay() {
    return Positioned.fill(
      child: Container(
        color: Colors.white.withOpacity(0.4),
        padding: EdgeInsets.only(right: 30, top: 20),
        alignment: Alignment.topRight,
        child: Icon(
          Icons.check_circle,
          color: AppColor.weirdGreen,
        ),
      ),
    );
  }
}
