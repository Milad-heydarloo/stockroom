
import 'package:http/http.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:flutter/foundation.dart';

Client getClient() {
  return Client();
}

class PocketBaseManager {
  static final PocketBaseManager _instance = PocketBaseManager._internal();
  late PocketBase _pb; // استفاده از late برای متغیر
  bool _isInitialized = false; // پرچم برای بررسی اینیشیالیزیشن

  factory PocketBaseManager({required String url, required String lang}) {
    if (!_instance._isInitialized) {
      _instance._pb = PocketBase(
        url,
        lang: lang,
        httpClientFactory: kIsWeb ? () => getClient() : null,
      );
      _instance._isInitialized = true; // تنظیم پرچم به true
    }
    return _instance;
  }

  PocketBaseManager._internal();

  PocketBase get client => _pb; // دسترسی به نمونه PocketBase
}
