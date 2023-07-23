import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qoute_app/services/Networking.dart';

import 'Model/ImageModel.dart';
import 'Model/qoute.dart';

class QouteImage {
  late Qoute qoute;
  late String img;
  Future<void> getRandomQouteAndImg() async {
    qoute = await Qoute().getRandomQoute();
    await RandomImage(imgDesc: qoute.desc)
        .getRandomImag()
        .then((value) => img = value);
  }
}
