import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeviceTypes{
  static const String FAN = "FAN";
  static const String DOOR = "DOOR";
  static const String WINDOW = "WINDOW";
  static const String BULB = "BULB";
  static const String SOCKET = "SOCKET";

  static const Map<String, IconData> ICONS_MAP = {
    FAN : Icons.ac_unit,
    DOOR : Icons.sensor_door,
    WINDOW : Icons.sensor_window,
    BULB : Icons.lightbulb,
    SOCKET : Icons.adjust
  };
}