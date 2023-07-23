import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:share_plus/share_plus.dart';

import '../../linked/qoute_image.dart';

class HomePage extends StatefulWidget {
  // Qoute qoute;
  // String img;
  QouteImage qoute_img;
  HomePage({super.key, required this.qoute_img});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  GlobalKey globalKey = GlobalKey();
  Uint8List? pngBytes;
  late AnimationController _controller;
  void scaleMethod() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Duration of two rotations
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.stop();
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the animation controller
    super.dispose();
  }

  @override
  void initState() {
    scaleMethod();
    super.initState();
  }

  void getDataFromit() async {
    await widget.qoute_img.getRandomQouteAndImg();
  }

  Future<void> _capturePng() async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    // if (boundary.debugNeedsPaint) {
    if (kDebugMode) {
      print("Waiting for boundary to be painted.");
    }
    await Future.delayed(const Duration(milliseconds: 20));
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    pngBytes = byteData!.buffer.asUint8List();
    if (kDebugMode) {
      print(pngBytes);
    }
    if (mounted) {
      _onShareXFileFromAssets(context, byteData);
    }
    // }
  }

  void _onShareXFileFromAssets(BuildContext context, ByteData? data) async {
    final box = context.findRenderObject() as RenderBox?;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final buffer = data!.buffer;
    final shareResult = await Share.shareXFiles(
      [
        XFile.fromData(
          buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
          name: 'screen_shot.png',
          mimeType: 'image/png',
        ),
      ],
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );

    scaffoldMessenger.showSnackBar(getResultSnackBar(shareResult));
  }

  SnackBar getResultSnackBar(ShareResult result) {
    return SnackBar(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Share result: ${result.status}"),
          if (result.status == ShareResultStatus.success)
            Text("Shared to: ${result.raw}")
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RepaintBoundary(
        key: globalKey,
        child: Container(
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
            filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 30.0, top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.green.withOpacity(0.6)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.refresh,
                              size: 34,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            // scaleMethod();
                            getDataFromit();
                          });
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
                              ScaleTransition(
                                scale: _controller,
                                child: Container(
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
                              color: Colors.green.withOpacity(0.5)),
                          child: Text(
                            textAlign: TextAlign.center,
                            widget.qoute_img.qoute.author,
                            style: TextStyle(
                              fontSize: 15.0,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.green,
          onPressed: _capturePng,
          label: const Text('Take screenshot'),
          icon: const Icon(Icons.share_rounded),
        ),
      ),
    );
  }
}
