import 'package:vibration/vibration.dart';

class VibratorHelper{
  static final VibratorHelper _vibratorHelper = VibratorHelper._internal();

  factory VibratorHelper(){
    return _vibratorHelper;
  }

  VibratorHelper._internal();

  vibrate() async {
    try {
      if ((await Vibration.hasCustomVibrationsSupport())!) {
        Vibration.vibrate(duration: 10);
      } else {
        Vibration.vibrate();
        await Future.delayed(Duration(milliseconds: 10));
        Vibration.vibrate();
      }
    }
    catch(ex){
      print(ex);
    }
  }

  vibrateDelay(int delayMillis) async {
    try {
      if ((await Vibration.hasCustomVibrationsSupport())!) {
        Vibration.vibrate(duration: delayMillis);
      } else {
        Vibration.vibrate();
        await Future.delayed(Duration(milliseconds: delayMillis));
        Vibration.vibrate();
      }
    }
    catch(ex){
      print(ex);
    }
  }
}