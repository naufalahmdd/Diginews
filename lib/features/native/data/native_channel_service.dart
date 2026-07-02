import 'package:flutter/services.dart';
import '../../../core/constants/app_constant.dart';

class NativeChannelService {
  static const MethodChannel _channel = MethodChannel('com.utd.diginews/native');

  
  static Future<String> reverseNimViaNative() async {
    try {
      final String result = await _channel.invokeMethod(
        'reverseNim',
        {'nim': AppConstants.nim},
      );
      return result;
    } on PlatformException catch (e) {
      return 'Error native: ${e.message}';
    }
  }
}