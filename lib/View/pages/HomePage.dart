import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:qoute_app/Model/qoute.dart';
import 'package:qoute_app/View/pages/splash.dart';

import '../../Model/ImageModel.dart';
import '../../qoute_image.dart';

class HomePage extends StatefulWidget {
  // Qoute qoute;
  // String img;
  QouteImage qoute_img;
  HomePage({super.key, required this.qoute_img});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  void getDataFromit() async {
    await widget.qoute_img.getRandomQouteAndImg();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              // opacity: AlwaysStoppedAnimation(0.5),
              image: NetworkImage(widget.qoute_img.img),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 30.0, top: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white.withOpacity(0.2)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.refresh,
                              size: 34,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            getDataFromit();
                          });

                          // getDataFromit();
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 20.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 300.0, top: 20),
                        //   child: Image(
                        //     image: AssetImage('assets/images/right-quotes.png'),
                        //     height: 24,
                        //     width: 24,
                        //     color: Colors.black,
                        //   ),
                        // ),

                        Padding(
                          padding: const EdgeInsets.only(top: 70.0),
                          child: Stack(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  RotationTransition(
                                    turns:
                                        new AlwaysStoppedAnimation(180 / 360),
                                    child: Image(
                                      image: AssetImage(
                                          'assets/images/right-quotes.png'),
                                      height: 80,
                                      width: 80,
                                      color: Colors.black45,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.all(45),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white38,
                                ),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  widget.qoute_img.qoute.content,
                                  style: TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2,
                                      fontFamily: 'EduSABeginner'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white.withOpacity(0.5),
                          ),
                          child: Text(
                            textAlign: TextAlign.center,
                            widget.qoute_img.qoute.author,
                            style: TextStyle(
                              fontSize: 15.0,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
