import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class NetworkHelper {
  final String URL;

  NetworkHelper(this.URL);

  Future<List<dynamic>> getData() async {
    http.Response response = await http.get(Uri.parse(URL));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return Future.error('Somthing Wrong');
    }
  }
   Future<Map<String,dynamic>> getDataforRandomImag() async {
    http.Response response = await http.get(Uri.parse(URL));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return Future.error('Somthing Wrong');
    }
  }
}
