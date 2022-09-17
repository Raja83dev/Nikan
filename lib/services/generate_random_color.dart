import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nikan_app/constans.dart';

Color generateRandomColor() {
  return colorsList[Random().nextInt(colorsList.length)];
}
