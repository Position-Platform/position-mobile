// ignore_for_file: avoid_print
import 'package:flutter/services.dart';

changeStatusColor(Color color) async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: color,
  ));
}
