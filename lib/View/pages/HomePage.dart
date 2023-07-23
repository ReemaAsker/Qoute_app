import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:qoute_app/Model/qoute.dart';
import 'package:qoute_app/View/pages/splash.dart';

import '../../qoute&image.dart';

class HomePage extends StatefulWidget {
  Qoute qoute;
  String img;

  HomePage({super.key, required this.qoute, required this.img});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  void getDataFromit() {
    setState(() {
      // qouteimage qouteImg = qouteimage();
      // qouteImg.getRandomBackgroundImag();
      // qouteImg.getRandomQoute();
      // widget.img = qouteimage().img;
      // widget.qoute = qouteimage().qoute;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                // opacity: AlwaysStoppedAnimation(0.5),
                image: NetworkImage(widget.img),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Icon(
                            Icons.refresh,
                            size: 34,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          // getDataFromit();
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 20.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 300.0),
                            child: Image(
                              image:
                                  AssetImage('assets/images/right-quotes.png'),
                              height: 24,
                              width: 24,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            widget.qoute.content,
                            style: TextStyle(fontSize: 30.0, letterSpacing: 2),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RotationTransition(
                            turns: new AlwaysStoppedAnimation(180 / 360),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 250.0),
                              child: Image(
                                image: AssetImage(
                                    'assets/images/right-quotes.png'),
                                height: 24,
                                width: 24,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 100,
                          ),
                          Container(
                            color: Colors.grey[200],
                            child: Text(
                              widget.qoute.author,
                              style:
                                  TextStyle(fontSize: 25.0, letterSpacing: 2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
