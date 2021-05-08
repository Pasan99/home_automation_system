import 'package:flutter/material.dart';
import 'package:home_automation_system/values/colors.dart';

class AppConfig{
  static final double BUTTON_BORDER_RADIUS = 14;
  static final double CARD_BORDER_RADIUS = 20;
  static final double TEXT_FIELD_BORDER_RADIUS = 14;
}

class AppStyles{
  static final ButtonStyle OUTLINE_BUTTON_STYLE = OutlinedButton.styleFrom(
    side: BorderSide(width: 1, color: AppColors.MAIN_COLOR),
    shape: new RoundedRectangleBorder(
    borderRadius: new BorderRadius.circular(AppConfig.BUTTON_BORDER_RADIUS))
  );
}