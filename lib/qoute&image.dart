import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qoute_app/services/Networking.dart';

import 'Model/ImageModel.dart';
import 'Model/qoute.dart';

class qouteimage {
  late Qoute qoute = Qoute();
  String img = "";
  // Future<String> getfromApiimg() async {
  //   await qoute.getRandomQoute().whenComplete(() {
  //     RandomImage(imgDesc: qoute.desc)
  //         .getRandomImag()
  //         .then((value) => {img = value});
  //     return img;
  //   });
  //   return "";
  // }

  // Future<List<dynamic>> getfromApiQoute() async {
  //   List<dymnic
  //   qoute = Qoute();
  //   return await qoute.getRandomQoute();
  // }
  Future<void> getRandomQoute() async {
    List<dynamic> qoutData =
        await NetworkHelper('https://api.quotable.io/quotes/random').getData();
    qoute.content = qoutData[0]['content'];
    qoute.author = qoutData[0]['author'];
    qoute.desc = qoutData[0]['tags'][0];
    img =
        "https://random.imagecdn.app/v1/image?category=${qoute.desc}&format=json";
    print(img);
  }

  // void getRandomBackgroundImag() {

  // }
}
