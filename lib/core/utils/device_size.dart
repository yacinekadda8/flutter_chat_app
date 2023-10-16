import 'package:flutter/material.dart';

class DeviceSize{
  static Size mq(context) {
    return MediaQuery.of(context).size;
  }
}