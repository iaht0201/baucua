// import 'package:audioplayers/audioplayers.dart';

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:just_audio/just_audio.dart';
// import 'package:flutter_tts/flutter_tts.dart';
import 'package:shake/shake.dart';
import 'dart:math';

class DemoPage extends StatefulWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final FlutterTts flutterTts = FlutterTts();
  final _player = AudioPlayer();
  void textToSpeech(String text) async {
    await flutterTts.setLanguage("vi");
    await flutterTts.setVolume(1);
    await flutterTts.setSpeechRate(0.6);
    await flutterTts.speak(text);
  }

  int shakeCount = 0;
  var nums = [1, 2, 3, 4, 5, 6];
  int num1 = 0;
  int num2 = 0;
  int num3 = 0;
  // speak(String text) async {
  //   await flutterTts.setLanguage("vi");
  //   await flutterTts.setPitch(1);
  //   await flutterTts.speak(text);
  // }

  // AudioPlayer? player;
  handleRandom() {
    num1 = nums[Random().nextInt(nums.length)];
    num2 = nums[Random().nextInt(nums.length)];
    num3 = nums[Random().nextInt(nums.length)];
  }

  void initState() {
    super.initState();

    handleRandom();
    _music();
    // final player = AudioPlayer();
    // player.setSource(AssetSource('assets/laclaclac.mp3')) ;
    // ShakeDetector detector = ShakeDetector.autoStart(
    //   onPhoneShake: () {
    //     setState(() {
    //       shakeCount++ ;
    //     });
    //     // Do stuff on phone shake
    //   },
    //   minimumShakeCount: 1,
    //   shakeSlopTimeMS: 500,
    //   shakeCountResetTime: 3000,
    //   shakeThresholdGravity: 2.7,
    // );
  }

  String handleNumberToText(int num) {
    switch (num) {
      case 1:
        return "Nai";
      case 2:
        return "Bầu";
      case 3:
        return "Gà";
      case 4:
        return "Cá";
      case 5:
        return "Cua";
      case 6:
        return "Tôm";
      default:
        return "";
    }
  }

  String handleText(int num1, int num2, int num3) {
    if (num1 == num2 && num2 == num3) {
      return "Có 3 con ${handleNumberToText(num1)}";
    } else if ((num1 == num2 && num1 != num3)) {
      return "Có 2 ${handleNumberToText(num1)} , 1 ${handleNumberToText(num3)}";
    } else if ((num1 == num3 && num1 != num2)) {
      return "Có 2 ${handleNumberToText(num1)} , 1 ${handleNumberToText(num2)}";
    } else if ((num2 == num3 && num1 != num2)) {
      return "Có 2 ${handleNumberToText(num2)} , 1 ${handleNumberToText(num1)}";
    }
    return "Có 1  ${handleNumberToText(num1)}, 1  ${handleNumberToText(num2)} , 1 ${handleNumberToText(num3)}";
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _music() async {
    await _player.setAsset("assets/laclaclac.mp3");
  }

  @override
  Widget build(BuildContext context) {
    ShakeDetector.autoStart(
      onPhoneShake: () async {
        await _player.setAsset("assets/laclaclac.mp3");
        _player.setVolume(1);
        await _player.play();
        // speak("xin chào : ${num1}") ;
        //  player!.play(DeviceFileSource("assets/laclaclac.mp3"));
        setState(() {
          handleRandom();
        });
        // Do stuff on phone shake
      },
      // minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            GestureDetector(
              child: Text("PLay"),
              onTap: () async {
                  await _player.pause();
                textToSpeech("Chúc mừng bạn ${handleText(num1, num2, num3)}");
              },
            ),
            Center(
              child: Text(":${num1} : ${num2} : ${num3}"),
            ),
          ],
        ),
      )),
    );
  }
}
