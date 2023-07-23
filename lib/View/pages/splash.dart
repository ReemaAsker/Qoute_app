import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qoute_app/Model/qoute.dart';
import 'package:qoute_app/View/pages/HomePage.dart';
import 'package:qoute_app/linked/qoute_image.dart';

import '../../Model/ImageModel.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  /*
  void getfromApiQoute() {
    qouteimage().getfromApiQoute();
    qouteimage().getfromApiimg();
    String img = qouteimage().img;
    Qoute qoute = qouteimage().qoute;
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HomePage(qoute: qoute, img: img);
    }));
  }

  */
  String imgUrl = "";
  void getfromApiQoute() async {
    
    QouteImage qouteImg = QouteImage();
    await qouteImg.getRandomQouteAndImg().whenComplete(() {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HomePage(
          qoute_img: qouteImg,
        );
      }));
    });
  }

  @override
  void initState() {
    
    getfromApiQoute();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
