import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'widgets_home_platform_interface.dart';

/// An implementation of [WidgetsHomePlatform] that uses method channels.
class MethodChannelWidgetsHome extends WidgetsHomePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('widgets_home');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
