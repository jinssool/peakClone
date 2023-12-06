import 'package:flutter/material.dart';
import 'dart:math';

Color generateRandomLightColor() {
  Random random = Random();

  int red = random.nextInt(108) + 148; // 128-255 (brighter red tones)
  int green = random.nextInt(108) + 148; // 128-255 (brighter green tones)
  int blue = random.nextInt(108) + 148; // 128-255 (brighter blue tones)

  return Color.fromARGB(255, red, green, blue);
}

Color checkColorContrast(Color color) {
  double luminance =
      (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;
  return luminance > 0.5 ? Colors.black : Colors.white;
}
