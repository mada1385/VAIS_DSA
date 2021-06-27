import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:vaisdsa/provider/auth_provider.dart';

// import '../models/http_exception.dart';

import '../components/custom_dialog.dart';

class AuthScreen extends StatelessWidget {
  static const String routeName = "/AuthScreen";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _nameKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _emailKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _passwordKey = GlobalKey<FormFieldState>();

  String _name;
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    double sh = deviceSize.height;
    double sw = deviceSize.width;
    int _animationDuration = 300;

    Auth _staticAuthProvider = Provider.of<Auth>(context);

    _showErrorDialog(String errorMessage) {
      showDialog(
        context: context,
        builder: (ctx) => CustomDialog(
          title: "Something went wrong..",
          description: errorMessage,
          positiveButtonText: null,
          negativeButtonText: "Okay",
        ),
      );
    }

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
            child: Selector<Auth, bool>(
              selector: (_, auth) => auth.isLogin,
              builder: (_, isLogin, __) => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 0.135 * sh,
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: _animationDuration),
                    height: isLogin ? 0.144 * sh : 0.750 * 0.144 * sh,
                    child: Image.asset("assets/logo.png"),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: _animationDuration),
                    height: isLogin ? 0.064 * sh : 0.750 * 0.064 * sh,
                    child: Text(
                      "DSA",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Signatra",
                        fontSize:
                            isLogin ? 0.064 * sh - 5 : 0.750 * 0.064 * sh - 5,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0.03 * sh,
                  ),
                  AnimatedContainer(
                      duration: Duration(milliseconds: _animationDuration),
                      height: isLogin ? 0.050 * sh : 0.020 * sh,
                      child: Text(
                        "Dental Smart Agriculture",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Signatra",
                          fontSize:
                              isLogin ? 0.04 * sh - 5 : 0.750 * 0.064 * sh - 5,
                        ),
                      )),
                  SizedBox(
                    height: 0.12 * sh,
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: _animationDuration),
                    height: isLogin ? 0.25 * sh : 0.540 * sh,
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(
                      horizontal: 0.054 * sw,
                      vertical: 0.010 * sh,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      color: const Color(0xFFFFFFFF),
                      // boxShadow: [
                      //   BoxShadow(
                      //     blurRadius: 2,
                      //     spreadRadius: 2,
                      //     color: Colors.black12,
                      //   )
                      // ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          TextFormField(
                            key: _emailKey,
                            keyboardType: TextInputType.emailAddress,
                            style: Theme.of(context).textTheme.headline3,
                            decoration: InputDecoration(
                              labelText: 'Email',
                            ),
                            validator: (email) {
                              if (!email.contains('@'))
                                return "Please, enter a valid email.";
                              if (email.lastIndexOf('@') >
                                  email.lastIndexOf('.'))
                                return "Please, enter a valid email.";
                              if (email.lastIndexOf('@') != email.indexOf('@'))
                                return "Please, enter a valid email.";
                              if (email.length < 10)
                                return "Email is too short.";
                              if (email.indexOf('@') == 0 ||
                                  email.lastIndexOf('.') == email.length - 1)
                                return "Please, enter a valid email.";

                              return null;
                            },
                            onSaved: (email) {
                              _email = email;
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
                            onChanged: (password) {
                              _password = password;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 0.060 * sh),
                  Selector<Auth, bool>(
                    selector: (_, auth) => auth.isLoading,
                    builder: (_, isLoading, __) => Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          height: 52,
                          width: double.maxFinite,
                          child: FlatButton(
                            color: Theme.of(context).primaryColor,
                            shape: StadiumBorder(),
                            disabledColor: Colors.grey,
                            child: Text(
                              isLogin ? 'LOGIN' : 'SIGNUP',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .apply(color: Colors.white),
                            ),
                            onPressed: isLoading
                                ? null
                                : () async {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();

                                      _staticAuthProvider.isLoading = true;

                                      // if (isLogin) {
                                      //   await _staticAuthProvider.login(
                                      //       _email, _password);
                                      // } else {
                                      //   await _staticAuthProvider.signup(
                                      //       _email, _password, _name);
                                      // }
                                      // Navigator.pushNamed(
                                      //     context, HomeScreen.routeName);
                                    }
                                  },
                          ),
                        ),
                        if (isLoading) CircularProgressIndicator(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
