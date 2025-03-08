import 'dart:async';

import 'package:covid_tracker/View/world_states.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'dart:math' as math;

import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose()
  {
    super.dispose();
    _controller.dispose();
  }

  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 5), () {
      Get.to(() => WorldStates());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
                child: Container(
                    height: 200,
                    width: 200,
                    child: Center(child: Image.asset("assets/virus.png"))),
                animation: _controller,
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(
                      angle: _controller.value * 2.0 * math.pi, child: child);
                }),
            SizedBox(
              height: MediaQuery.of(context).size.height * .08,
            ),
            Align(
                alignment: Alignment.center,
                child: Text(
                  "Covid_19\nTracker",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
