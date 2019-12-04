

import 'dart:collection';
import 'dart:ui';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';

class FPSTip extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return _FPSTipState();
  }
}

class _FPSTipState extends State<FPSTip> {

  static const maxFrames = 100;
  static const frameInterval = const Duration(microseconds: Duration.microsecondsPerSecond ~/ 60);
  final lastFrames = List<FrameTiming>();

  var originalCallback;
  var curFPS = 60;
  var avgFPS = 60;

  @override
  void initState() {
    
    originalCallback = window.onReportTimings;
    window.onReportTimings = _onReportTimings;

    super.initState();
  }

  void _onReportTimings(List<FrameTiming> timings) {

    if (originalCallback != null) {
      originalCallback(timings);
    }

    lastFrames.addAll(timings);

    var now = timings.last.timestampInMicroseconds(FramePhase.rasterFinish);

    while (true) {
      FrameTiming timing = lastFrames.first;
      if (timing == null) break;

      var start = timing.timestampInMicroseconds(FramePhase.buildStart);
      if (now - start > 1000 * 1000) {
        lastFrames.removeAt(0);
      } else {
        break;
      }
    }

    var start = lastFrames.first.timestampInMicroseconds(FramePhase.buildStart);
    var timeDelta = (now - start) / 1000;
    int fpsAvg = (lastFrames.length * 1000 / timeDelta).round();
    fpsAvg = fpsAvg > 60 ? 60 : fpsAvg;

    // int calFps = this.calFps();

    int timeRange = timings.last.totalSpan.inMilliseconds;
    int calFps = (1000 / timeRange).round();
    calFps = calFps > 60 ? 60 : calFps;

    developer.log('xxxxx cur frame Fps: ' + curFPS.toString() + ' avgFps: ' + fpsAvg.toString() + ' avgRange: ' + ((now - start)/1000).toString() + 'ms. count: ' + lastFrames.length.toString());

    // if (calFps != curFPS || avgFPS != fpsAvg) {
    //   setState(() {
    //     curFPS = calFps;
    //     avgFPS = fpsAvg;
    //   });
    // }
  }

  // int calFps() {

  //   var lastFrameSet = <FrameTiming>[];

  //   for (FrameTiming timing in lastFrames) {
  //     if (lastFrameSet.isEmpty) {
  //       lastFrameSet.add(timing);
  //     } else {
  //       var lastStart = lastFrameSet.last.timestampInMicroseconds(FramePhase.buildStart);
  //       var thisEnd = timing.timestampInMicroseconds(FramePhase.rasterFinish);
  //       var delta = frameInterval.inMicroseconds * 2;
  //       var range = lastStart - thisEnd;
  //       if (range > delta) {
  //         break;
  //       }
  //       lastFrameSet.add(timing);
  //     }
  //   }

  //   var framesCount = lastFrameSet.length;
  //   var costCount = lastFrameSet.map((t) {
  //     return (t.totalSpan.inMicroseconds ~/ frameInterval.inMicroseconds) + 1;
  //   }).fold(0, (a, b) => a+b);
  //   return (framesCount * 60 / costCount).round();
  // }

  @override
  Widget build(BuildContext context) {
    return Text("FPS: " + curFPS.toString() + ' avgFps: ' + avgFPS.toString());
  }
}