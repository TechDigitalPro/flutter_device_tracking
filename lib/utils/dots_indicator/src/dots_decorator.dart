import 'package:flutter/material.dart';

const Size kDefaultSize = Size.square(10.0);
const EdgeInsets kDefaultSpacing = EdgeInsets.all(6.0);
const ShapeBorder kDefaultShape = CircleBorder();

class DotsDecorator {
  final Color color;
  final Color activeColor;
  final Size size;
  final Size activeSize;
  final ShapeBorder shape;
  final ShapeBorder activeShape;
  final EdgeInsets spacing;

  const DotsDecorator({
    this.color = const Color(0xFFFFFFFF),
    this.activeColor = const Color(0xFFFFFFFF),
    this.size = kDefaultSize,
    this.activeSize = kDefaultSize,
    this.shape = kDefaultShape,
    this.activeShape = kDefaultShape,
    this.spacing = kDefaultSpacing,
  });
}
