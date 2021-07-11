import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vaisdsa/models/session.dart';

class Sessiondetail extends StatefulWidget {
  final Session session;

  const Sessiondetail({Key key, this.session}) : super(key: key);
  @override
  _SessiondetailState createState() => _SessiondetailState();
}

class _SessiondetailState extends State<Sessiondetail> {
  dynamic session;
  final PageController ctr = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF579955),
      appBar: AppBar(
        backgroundColor: Color(0xFF579955),
        centerTitle: true,
        title: Container(
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
      body: CustomPaint(
        painter: AuthScreenBackground(),
        child: widget.session.pricturesstamps.isNotEmpty
            ? Column(
                children: [
                  Expanded(
                    child: PageView(
                      controller: ctr,
                      children: widget.session.pricturesstamps
                          .map((e) => Row(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.scaleDown,
                                            image: FileImage(
                                                File(e["imagepath"])))),
                                  ),
                                  Expanded(
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              // fit: BoxFit,cd
                                              image: FileImage(
                                                  File(e["hsiimagepath"])))),
                                      child: Padding(
                                        padding:
                                            const EdgeInsetsDirectional.only(
                                                top: 20, end: 20),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              e["tag"] ?? "",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              e["timestamp"],
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              e["lang"],
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              e["lat"],
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ))
                          .toList(),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 45,
                        ),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4),
                            itemCount: widget.session.pricturesstamps.length,
                            itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  ctr.animateToPage(index,
                                      curve: Curves.easeOut,
                                      duration: Duration(milliseconds: 500));
                                },
                                child: Card(
                                  color: Colors.transparent,
                                  elevation: 20,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .2,
                                    decoration: BoxDecoration(
                                        // boxShadow: [
                                        //   BoxShadow(
                                        //       offset: Offset(0, .75),[
                                        //       blurRadius: 2,
                                        //       color: Colors.black12)
                                        // ],
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: FileImage(File(widget.session
                                                    .pricturesstamps[index]
                                                ["imagepath"])))),
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "لا يوجد صور لهذة الجلسة ",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  )
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

    paint.color = const Color(0xFFffffff);
    canvas.drawPath(firstWave, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
