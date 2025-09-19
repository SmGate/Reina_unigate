import 'package:flutter/material.dart';

extension WidgetPadding on Widget {
  Widget withPadding([EdgeInsets padding = const EdgeInsets.all(8)]) =>
      Padding(padding: padding, child: this);
}
