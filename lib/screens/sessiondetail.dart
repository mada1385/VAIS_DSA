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
        title: Center(
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
      ),
      body: CustomPaint(
        painter: AuthScreenBackground(),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: ctr,
                children: widget.session.pricturesstamps
                    .map((e) => Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: FileImage(File(e["imagepath"])))),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(
                                top: 20, end: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  e["tag"],
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
                        ))
                    .toList(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemCount: widget.session.pricturesstamps.length,
                itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      ctr.jumpToPage(index);
                    },
                    child: Card(
                      color: Colors.transparent,
                      elevation: 20,
                      child: Container(
                        width: MediaQuery.of(context).size.width * .2,
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
                                    .pricturesstamps[index]["imagepath"])))),
                      ),
                    )),
              ),
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
