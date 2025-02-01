import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:typeset/typeset.dart';

extension ThemeExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  Size get size => MediaQuery.sizeOf(this);
  double deviceHeight(double h) => size.height * h;
  double deviceWidth(double w) => size.width * w;
}

extension PaddingExtension on Widget {
  Padding padAll([double value = 0.0]) {
    return Padding(
      padding: EdgeInsets.all(value),
      child: this,
    );
  }

  Padding padSymmetric({double horizontal = 0, double vertical = 0.0}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }

  Padding padOnly({
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
    double left = 0.0,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: top, right: right, bottom: bottom, left: left),
      child: this,
    );
  }

  // FADING ANIMATIONS ON THE WIDGET
  Animate fadeInFromLeft({
    Duration? delay,
    Duration? animationDuration,
    Offset? offset,
  }) =>
      animate(delay: delay ?? 300.ms)
          .move(
            duration: animationDuration ?? 300.ms,
            begin: offset ?? const Offset(-10, 0),
          )
          .fade(duration: animationDuration ?? 300.ms);

          //
  Animate fadeInFromTop({
    Duration? delay,
    Duration? animationDuration,
    Offset? offset,
  }) =>
      animate(delay: delay ?? 300.ms)
          .move(
            duration: animationDuration ?? 300.ms,
            begin: offset ?? const Offset(0, -10),
          )
          .fade(duration: animationDuration ?? 300.ms);

  Widget debugBorder({Color? color}) {
    if (kDebugMode) {
      return DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: color ?? Colors.red, width: 4),
        ),
        child: this,
      );
    } else {
      return this;
    }
  }
}

extension ChildrenListSpacing on List<Widget> {
  List<Widget> fadeInFromLeft({
    Duration? delay,
    Duration? animationDuration,
    Offset? offset,
  }) {
    return animate(delay: delay ?? 300.ms, interval: 200.ms)
        .move(
          duration: animationDuration ?? 300.ms,
          begin: offset ?? const Offset(-10, 0),
        )
        .fade(duration: animationDuration ?? 300.ms);
  }

  List<Widget> paddingInColumn(double height) {
    return expand(
      (element) => [
        element,
        SizedBox(
          height: height,
        )
      ],
    ).toList();
  }

  List<Widget> paddingInRow(double width) {
    return expand(
      (element) => [
        element,
        SizedBox(
          width: width,
        )
      ],
    ).toList();
  }
}

extension StringExtension on String {
  void defaultLog({String? name}) => kDebugMode ? log(this, name: name ?? '') : null;
}
