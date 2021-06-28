import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaisdsa/provider/camera_provider.dart';
import 'package:vaisdsa/screens/browseoldannotation.dart';

import 'camera_screen.dart';

class Homescreen extends StatefulWidget {
  final camera;

  const Homescreen({Key key, this.camera}) : super(key: key);
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int index = 0;
  // var camera;
  // List<Widget> tabs = [
  //   Mainscreen(
  //     camera: camera,
  //   ),
  //   Mainscreen(),
  // ];
  // @override
  // void initState() {
  //   camera = widget.camera;
  //   super.initState();
  // }
  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Provider.of<CameraProvider>(context, listen: false).getfile();
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      Mainscreen(
        camera: widget.camera,
      ),
      Mainscreen(),
    ];
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Color(0xFF579955),
          currentIndex: index,
          onTap: (val) {
            setState(() {
              index = val;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.logout), label: "logout"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "configs")
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.camera_enhance),
        //   onPressed: () {},
        //   backgroundColor: Color(0xFF579955),
        // ),
        // appBar: AppBar(
        //     toolbarHeight: 120,
        //     elevation: 0,
        //     centerTitle: true,
        //     backgroundColor: Color(0xFF579955),
        //     title: Column(
        //       children: [

        //       ],
        //     )),
        body: CustomPaint(
          painter: AuthScreenBackground(),
          size: MediaQuery.of(context).size,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: tabs[index],
          ),
        ));
  }
}

class Mainscreen extends StatelessWidget {
  final camera;

  const Mainscreen({this.camera});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.camera_enhance),
      //   onPressed: () {},
      //   backgroundColor: Color(0xFF579955),
      // ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Container(
              height: 60,
              child: Image.asset("assets/logo.png"),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Container(
                child: Text(
                  "DSA",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Signatra",
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Container(
                child: Text(
                  "Dental Smart Agriculture",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Signatra",
                      fontSize: 24),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            // Row(
            //   children: [
            //     Container(
            //       child: Text(
            //         "Previous Pictures",
            //         style: TextStyle(
            //             color: Colors.white,
            //             fontFamily: "Signatra",
            //             fontSize: 24,
            //             fontWeight: FontWeight.bold),
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),

                  Card(
                    color: Colors.transparent,
                    elevation: 30,
                    child: FlatButton(
                      color: Theme.of(context).primaryColor,
                      shape: StadiumBorder(),
                      disabledColor: Colors.grey,
                      onPressed: () {
                        Provider.of<CameraProvider>(context, listen: false)
                            .addTransaction();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TakePictureScreen(
                                      camera: camera,
                                    )));
                      },
                      child: Text(
                        "start session",
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            .apply(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    color: Colors.transparent,
                    elevation: 30,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Browseoldannotaion()));
                        // Provider.of<CameraProvider>(context, listen: false)
                        //     .jsonfilebackup();
                      },
                      child: Text(
                        "Browse old session",
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            .apply(color: Colors.white),
                      ),
                      color: Theme.of(context).primaryColor,
                      shape: StadiumBorder(),
                      disabledColor: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    color: Colors.transparent,
                    elevation: 30,
                    child: FlatButton(
                      onPressed: () {
                        // Provider.of<CameraProvider>(context, listen: false)
                        //     .synctofirebase();
                      },
                      child: Text(
                        "User Profile",
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            .apply(color: Colors.white),
                      ),
                      color: Theme.of(context).primaryColor,
                      shape: StadiumBorder(),
                      disabledColor: Colors.grey,
                    ),
                  ),

                  // Newscard(),
                  // Newscard(),
                  // Newscard(),
                  // Newscard(),
                  // Newscard(),
                  // Newscard(),
                  // // SizedBox(
                  // //   height: 10,
                  // // ),
                  // Container(
                  //   height: 200,
                  //   width: double.infinity,
                  //   decoration: BoxDecoration(
                  //     color: Colors.transparent,
                  //     image: DecorationImage(
                  //         image:
                  //             AssetImage("assets/agritech-series-workforce-mgmt.png"),
                  //         fit: BoxFit.fill),
                  //     boxShadow: [
                  //       BoxShadow(
                  //           color: Colors.black54, blurRadius: 5, offset: Offset(0, 5))
                  //     ],
                  //   ),
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       Image.asset(
                  //         "assets/DSA_MitgliedCCI-1170x555.jpeg",
                  //         height: 75,
                  //       ),
                  //       Text(
                  //         "Dental Smart Agriculture",
                  //         style: TextStyle(
                  //             color: Colors.white,
                  //             fontFamily: "Signatra",
                  //             fontSize: 36),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Container(
                  //   width: double.infinity,
                  //   decoration: BoxDecoration(
                  //     color: Colors.transparent,
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 5),
                  //     child: Text(
                  //       "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                  //       style: TextStyle(
                  //         fontFamily: "Signatra",
                  //         fontSize: 16,
                  //         backgroundColor: Colors.transparent,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // // Container(
                  // //   height: 150,
                  // //   width: double.infinity,
                  // //   decoration: BoxDecoration(
                  // //     color: Colors.white,
                  // //     // image: DecorationImage(
                  // //     //     image: AssetImage("assets/damaged_leaves.jpeg"),
                  // //     //     fit: BoxFit.fill),
                  // //     // boxShadow: [
                  // //     //   BoxShadow(
                  // //     //       color: Colors.black54, blurRadius: 5, offset: Offset(0, 5))
                  // //     // ],
                  // //   ),
                  // //   child: Row(
                  // //     mainAxisAlignment: MainAxisAlignment.end,
                  // //     crossAxisAlignment: CrossAxisAlignment.start,
                  // //     children: [
                  // //       Text(
                  // //         "Start your session here",
                  // //         style: TextStyle(
                  // //             color: Color(0xFF579955),
                  // //             fontFamily: "Signatra",
                  // //             fontWeight: FontWeight.bold,
                  // //             fontSize: 24),
                  // //       ),
                  // //       SizedBox(
                  // //         width: 10,
                  // //       ),
                  // //       Padding(
                  // //         padding: const EdgeInsets.only(top: 15),
                  // //         child: Image.asset(
                  // //             "assets/vippng.com-curve-arrow-png-58544.png"),
                  // //       ),
                  // //     ],
                  // //   ),
                  // // ),
                  // // SizedBox(
                  // //   height: 10,
                  // // ),
                  // Container(
                  //   height: 200,
                  //   width: double.infinity,
                  //   decoration: BoxDecoration(
                  //     color: Colors.transparent,
                  //     image: DecorationImage(
                  //         image: AssetImage("assets/damaged_leaves.jpeg"),
                  //         fit: BoxFit.fill),
                  //     boxShadow: [
                  //       BoxShadow(
                  //           color: Colors.black54, blurRadius: 5, offset: Offset(0, 5))
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Container(
                  //   width: double.infinity,
                  //   decoration: BoxDecoration(
                  //     color: Colors.transparent,
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 5),
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         Text(
                  //           "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                  //           style: TextStyle(
                  //               fontFamily: "Signatra",
                  //               fontSize: 16,
                  //               backgroundColor: Colors.transparent),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Container(
                  //   height: 200,
                  //   width: double.infinity,
                  //   decoration: BoxDecoration(
                  //     color: Colors.transparent,
                  //     image: DecorationImage(
                  //         image: AssetImage("assets/damaged_leaves.jpeg"),
                  //         fit: BoxFit.fill),
                  //     boxShadow: [
                  //       BoxShadow(
                  //           color: Colors.black54, blurRadius: 5, offset: Offset(0, 5))
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Container(
                  //   width: double.infinity,
                  //   decoration: BoxDecoration(
                  //     color: Colors.transparent,
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 5),
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         Text(
                  //           "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                  //           style: TextStyle(
                  //             fontFamily: "Signatra",
                  //             fontSize: 16,
                  //             backgroundColor: Colors.transparent,
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Container(
                  //   height: 200,
                  //   width: double.infinity,
                  //   decoration: BoxDecoration(
                  //     color: Colors.transparent,
                  //     image: DecorationImage(
                  //         image: AssetImage("assets/damaged_leaves.jpeg"),
                  //         fit: BoxFit.fill),
                  //     boxShadow: [
                  //       BoxShadow(
                  //           color: Colors.black54, blurRadius: 5, offset: Offset(0, 5))
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Container(
                  //   width: double.infinity,
                  //   decoration: BoxDecoration(
                  //     color: Colors.transparent,
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 5),
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         Text(
                  //           "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                  //           style: TextStyle(fontFamily: "Signatra", fontSize: 16),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                ],
              ),
            ),
          ],
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
