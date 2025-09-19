import 'package:flutter/material.dart';

extension SizedBoxExtension on num {
  SizedBox get vertical => SizedBox(height: toDouble());

  SizedBox get horizontal => SizedBox(width: toDouble());

  SizedBox get squareBox => SizedBox(height: toDouble(), width: toDouble());
}
