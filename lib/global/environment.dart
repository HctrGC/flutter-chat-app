import 'dart:io';

class Environment {
  static String apiUrl = 'http://localhost:3000/api';
  static String socketUrl = Platform.isAndroid ? 'http://10.0.2.2:3000' : 'http://localhost:3000';
}