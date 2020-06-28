import 'package:best_flutter_ui_templates/fitness_app/dialog/loading_dialog.dart';
import 'package:best_flutter_ui_templates/fitness_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:best_flutter_ui_templates/fitness_app/auth/inputWidget.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../navigation_home_screen.dart';
import 'background.dart';

class LoginUI extends StatefulWidget {
  LoginUI({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginUI>
    with SingleTickerProviderStateMixin {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User main = User.main;

  Future<FirebaseUser> _handleSignIn() async {
    LoadingDialog.ShowLoadingDialog(context);
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;

    if (user.uid != null) {
      print("signed in " + user.displayName);
      //get data
      setState(() {
        main.email = user.email;
        main.id = 0;
        main.name = user.displayName;
        main.phone = user.phoneNumber;
        main.pictureUrl = googleUser.photoUrl;
        main.loginBy = 'gg';
      });
      //go to home page
      LoadingDialog.HideLoadingDialog(context);
      await Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new NavigationHomeScreen()));
    } else {
      LoadingDialog.ShowLoadingDialog(context);
      print('something wrong!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Background(),
      Column(
        children: <Widget>[
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.3),
          ),
          Center(
            child: Column(
              children: <Widget>[
                SignInButton(
                  Buttons.Google,
                  onPressed: () => _handleSignIn(),
                ),
                SignInButton(
                  Buttons.Facebook,
                  onPressed: () {
                    print('facebook signin context');
                  },
                ),
              ],
            ),
          )
        ],
      ),
    ]);
  }
}

Widget roundedRectButton(
    String title, List<Color> gradient, bool isEndIconVisible) {
  return Builder(builder: (BuildContext mContext) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Stack(
        alignment: Alignment(1.0, 0.0),
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(mContext).size.width / 1.7,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              gradient: LinearGradient(
                  colors: gradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
            ),
            child: Text(title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500)),
            padding: EdgeInsets.only(top: 16, bottom: 16),
          ),
          Visibility(
            visible: isEndIconVisible,
            child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: ImageIcon(
                  AssetImage("assets/images/ic_forward.png"),
                  size: 30,
                  color: Colors.white,
                )),
          ),
        ],
      ),
    );
  });
}

const List<Color> signInGradients = [
  Color(0xFF0EDED2),
  Color(0xFF03A0FE),
];

const List<Color> signUpGradients = [
  Color(0xFFFF9945),
  Color(0xFFFc6076),
];
