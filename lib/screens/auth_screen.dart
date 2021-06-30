import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaisdsa/provider/auth_provider.dart';

class AuthScreen extends StatelessWidget {
  final bool login;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final GlobalKey<FormFieldState> _emailKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _passwordKey = GlobalKey<FormFieldState>();

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  AuthScreen({Key key, this.login}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    double sh = deviceSize.height;
    double sw = deviceSize.width;
    int _animationDuration = 300;

    Auth _staticAuthProvider = Provider.of<Auth>(context);

    // _showErrorDialog(String errorMessage) {
    //   showDialog(
    //     context: context,
    //     builder: (ctx) => CustomDialog(
    //       title: "Something went wrong..",
    //       description: errorMessage,
    //       positiveButtonText: null,
    //       negativeButtonText: "Okay",
    //     ),
    //   );
    // }

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: CustomPaint(
          painter: AuthScreenBackground(),
          size: deviceSize,
          child: Container(
            height: sh,
            width: sw,
            padding: EdgeInsets.symmetric(
              horizontal: 0.085 * sw,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 0.135 * sh,
                ),
                Image.asset("assets/logo.png"),
                AnimatedContainer(
                  duration: Duration(milliseconds: _animationDuration),
                  height: 0.064 * sh,
                  child: Text(
                    "DSA",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Signatra",
                      fontSize: 0.064 * sh - 5,
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.03 * sh,
                ),
                Text(
                  "Dental Smart Agriculture",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Signatra",
                    fontSize: 0.04 * sh - 5,
                  ),
                ),
                SizedBox(
                  height: 0.12 * sh,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TextFormField(
                        controller: username,
                        key: _emailKey,
                        keyboardType: TextInputType.emailAddress,
                        style: Theme.of(context).textTheme.headline3,
                        decoration: InputDecoration(
                          labelText: 'Username',
                        ),
                        validator: (email) {
                          if (!email.contains('@'))
                            return "Please, enter a valid email.";
                          if (email.lastIndexOf('@') > email.lastIndexOf('.'))
                            return "Please, enter a valid email.";
                          if (email.lastIndexOf('@') != email.indexOf('@'))
                            return "Please, enter a valid email.";
                          if (email.length < 10) return "Email is too short.";
                          if (email.indexOf('@') == 0 ||
                              email.lastIndexOf('.') == email.length - 1)
                            return "Please, enter a valid email.";

                          return null;
                        },
                      ),
                      TextFormField(
                        key: _passwordKey,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        style: Theme.of(context).textTheme.headline3,
                        decoration: InputDecoration(
                          labelText: 'Password',
                        ),
                        validator: (password) {
                          if (password.trim().length < 8)
                            return "Password must be 8 characters at least.";

                          return null;
                        },
                        controller: password,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 0.060 * sh),
                Loginsnackbarbutton(
                  login: login,
                  formKey: _formKey,
                  emailKey: _emailKey,
                  passwordKey: _passwordKey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Loginsnackbarbutton extends StatelessWidget {
  Loginsnackbarbutton({
    Key key,
    @required this.login,
    this.formKey,
    this.emailKey,
    this.passwordKey,
    this.username,
    this.password,
  }) : super(key: key);
  TextEditingController username;
  TextEditingController password;

  final GlobalKey<FormState> formKey;

  final GlobalKey<FormFieldState> emailKey;
  final GlobalKey<FormFieldState> passwordKey;
  final bool login;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      width: double.maxFinite,
      child: FlatButton(
          color: Theme.of(context).primaryColor,
          shape: StadiumBorder(),
          disabledColor: Colors.grey,
          child: Text(
            login ? 'LOGIN' : 'ADD USER',
            style: Theme.of(context)
                .textTheme
                .headline1
                .apply(color: Colors.white),
          ),
          onPressed: () {
            if (formKey.currentState.validate()) {}
          }),
    );
  }
}

class AuthScreenBackground extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double sw = size.width;
    double sh = size.height;
    Paint paint = Paint();

    Path firstWave = Path();

    firstWave.lineTo(0, 0.406 * sh);
    firstWave.quadraticBezierTo(0.081 * sw, 0.475 * sh, 0.508 * sw, 0.490 * sh);
    firstWave.quadraticBezierTo(0.912 * sw, 0.500 * sh, 1.000 * sw, 0.558 * sh);
    firstWave.lineTo(sw, 0);
    firstWave.close();

    paint.color = const Color(0xFF579955);
    canvas.drawPath(firstWave, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
