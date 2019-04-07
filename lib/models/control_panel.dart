import 'package:flutter/widgets.dart';

class ControlPanelModel {
  String showAllText;
  String closeAllText;
  BoxDecoration decoration;

  /// Constructor.
  ControlPanelModel(
      {this.showAllText = 'Show all.',
      this.closeAllText = 'Close all.',
      this.decoration});
}
