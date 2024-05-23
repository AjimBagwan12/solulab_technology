import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:solulab_technology/api/flower_api.dart';
import 'package:solulab_technology/screens/flower_list_screen.dart';

class SplashScreen extends StatefulWidget {
  final FlowerApi flowerApi;

  const SplashScreen({Key? key, required this.flowerApi}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => FlowerListScreen(api: widget.flowerApi)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      // Extend body behind the system navigation bar
      //extendBodyBehindAppBar: true,
      //extendBody: true,
      // Body
      body: Stack(
        children: [

          // App logo
          Center(

            // top: mq.height * .50,
            // right: mq.width * .50,
             // width: mq.width * .5,
            child: Image.asset('images/app_icon.png'),


          ),

          Positioned(
            bottom: mq.height * .15,
            width: mq.width,
            child: const Text(
                'SOLULAB TECHNOLOGY ❤️',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16, color: Colors.black87, letterSpacing: .5)),
          ),
        ],
      ),
    );
  }
}