import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'widgets_home_method_channel.dart';

abstract class WidgetsHomePlatform extends PlatformInterface {
  /// Constructs a WidgetsHomePlatform.
  WidgetsHomePlatform() : super(token: _token);

  static final Object _token = Object();

  static WidgetsHomePlatform _instance = MethodChannelWidgetsHome();

  /// The default instance of [WidgetsHomePlatform] to use.
  ///
  /// Defaults to [MethodChannelWidgetsHome].
  static WidgetsHomePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WidgetsHomePlatform] when
  /// they register themselves.
  static set instance(WidgetsHomePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
