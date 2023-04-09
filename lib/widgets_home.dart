import 'dart:async';
import 'package:flutter/services.dart';

class WidgetsHome {
  static const MethodChannel _channel = MethodChannel('widgets_home');

  // Agrega el método createCustomWidget
  static Future<void> createCustomWidget({
    required String text,
    required String imageUrl,
    required String backgroundColor,
    required double width,
    required double height,
  }) async {
    await _channel.invokeMethod('createCustomWidget', {
      'text': text,
      'imageUrl': imageUrl,
      'backgroundColor': backgroundColor,
      'width': width,
      'height': height,
    });
  }
}
