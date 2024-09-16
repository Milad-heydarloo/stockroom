
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:project/Get_X/Service/PocketBaseService.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'user_model.dart';

class AuthController extends GetxController {
  final PocketBaseManager _pocketBaseManager;

  AuthController()
      : _pocketBaseManager = PocketBaseManager(url: 'https://saater.liara.run', lang: 'en-US');

  PocketBase get pb => _pocketBaseManager.client;



  //Method to get SharedPreferences instance
  Future<SharedPreferences> _getPreferences() async {
    return await SharedPreferences.getInstance();
  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  void onInit() {
    super.onInit();
  }

  Future<User?> getUser() async {
    try {
      final prefs = await _getPreferences();
      final userJsonString = prefs.getString('user');
      if (userJsonString != null) {
        final userJson = jsonDecode(userJsonString) as Map<String, dynamic>;
        return User.fromJson(userJson);
      }
      return null;
    } catch (e) {
      print("Error in getUser: $e");
      return null;
    }
  }

  Future<void> clearUser() async {
    try {
      final prefs = await _getPreferences();
      await prefs.remove('user');
      update(['user']);
    } catch (e) {
      print("Error in clearUser: $e");
    }
  }

  void logout() async {
    await clearUser();
    Get.offAllNamed('/login');
  }

  Future<void> login(String email, String password) async {
    try {
      final authData = await pb.collection('users').authWithPassword(email, password);
      final userJson = authData.record!.toJson();
      final user = User.fromJson(userJson);
      user.password = password;

      // Check if the user has the required role in availability
      const requiredRoles = ['کارشناس خرید و فروش', 'مدیر'];
      if (user.availability.any((role) => requiredRoles.contains(role))) {
        // Save user data in shared preferences
        final prefs = await _getPreferences();
        final userJsonString = jsonEncode(user.toJson());
        await prefs.setString('user', userJsonString);

        Get.snackbar('ورود موفق', 'شما با موفقیت وارد شدید.', backgroundColor: Colors.green);
        Get.offAllNamed('/home');
      } else {
        Get.snackbar('ورود ناموفق', 'شما مجاز به ورود نیستید.', backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar('ورود ناموفق', 'ایمیل یا رمز عبور نادرست است. لطفاً دوباره تلاش کنید.', backgroundColor: Colors.red);
    }
  }

  Future<void> checkAndLogin() async {
    try {
      final user = await getUser();
      if (user != null && user.email.isNotEmpty && user.password.isNotEmpty) {
        // مرحله 2: اعتبارسنجی اطلاعات در سرور
        final authData = await pb.collection('users').authWithPassword(user.email, user.password);
        final serverUserJson = authData.record!.toJson();
        final serverUser = User.fromJson(serverUserJson);

        Get.offAllNamed('/home');
      } else {
        Get.offAllNamed('/login');
      }
    } catch (e) {
      Get.snackbar('ورود ناموفق', 'مشکلی در اعتبارسنجی رخ داده است. لطفاً دوباره تلاش کنید.', backgroundColor: Colors.red);
      Get.offAllNamed('/login');
    }
  }
}
