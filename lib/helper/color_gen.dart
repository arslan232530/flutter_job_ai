import 'dart:math';
import 'package:flutter/material.dart';

class PastelColorPair {
  final Color background;
  final Color text;

  PastelColorPair(this.background, this.text);
}

PastelColorPair pastelColorPairFromLabel(String label) {
  final random = Random(label.hashCode);

  // Base strong color
  final baseColor = Color.fromARGB(
    255,
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
  );

  final hsl = HSLColor.fromColor(baseColor);

  // Light pastel background
  final bgColor = hsl.withLightness(0.90).withSaturation(0.35).toColor();

  // Dark text color from same hue
  final textColor = hsl.withLightness(0.35).withSaturation(0.70).toColor();

  return PastelColorPair(bgColor, textColor);
}
