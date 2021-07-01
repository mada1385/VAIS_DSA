import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaisdsa/provider/auth_provider.dart';

class AuthScreen extends StatefulWidget {
  final bool login;

  AuthScreen({Key key, this.login}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<Auth>(context, listen: false).checkforsuperuser();
      // Provider.of<Auth>(context, listen: false).checkforuser(context);
    });

    super.initState();
  }

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
                Hero(tag: "logo", child: Image.asset("assets/logo.png")),
                Text(
                  "DSA",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Signatra",
                    fontSize: 0.064 * sh - 5,
                  ),
                ),
                SizedBox(
                  height: 0.03 * sh,
                ),
                Text(
                  "Data Science Africa",
                  style: TextStyle(
                    color: Color(0xFF579955),
                    fontFamily: "Signatra",
                    fontSize: 0.04 * sh - 5,
                  ),
                ),
                Text(
                  "Multispectral Data Collection App",
                  style: TextStyle(
                    color: Color(0xFF579955),
                    fontFamily: "Signatra",
                    fontSize: 0.03 * sh - 5,
                  ),
                ),
                SizedBox(
                  height: 0.06 * sh,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TextFormField(
                        controller: username,
                        // key: _emailKey,
                        keyboardType: TextInputType.emailAddress,
                        style: Theme.of(context).textTheme.headline3,
                        decoration: InputDecoration(
                          labelText: 'Username',
                        ),
                        validator: (email) {
                          if (email.length < 2) return "UserName is too short.";

                          return null;
                        },
                      ),
                      TextFormField(
                        // key: _passwordKey,
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
                  login: widget.login,
                  formKey: _formKey,
                  username: username,
                  password: password,
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
    this.username,
    this.password,
  }) : super(key: key);
  final TextEditingController username;
  final TextEditingController password;

  final GlobalKey<FormState> formKey;

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
            if (formKey.currentState.validate()) {
              login
                  ? Provider.of<Auth>(context, listen: false)
                      .login(username.text, password.text, context)
                  : Provider.of<Auth>(context, listen: false)
                      .adduser(username.text, password.text, context);
            }
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
