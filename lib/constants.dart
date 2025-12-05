import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

String kHostIP = "https://api.npoint.io";

String kFontFamily = 'Alexandria';

const Duration kTimeOutDurationLong = Duration(seconds: 60);
const Duration kTimeOutDuration = Duration(seconds: 30);
const Duration kTimeOutDuration2 = Duration(seconds: 15);
const Duration kTimeOutDuration3 = Duration(seconds: 7);

const Color kStartLocationColor = Color(0xff1E90FF);
const Color kEndLocationColor = Color(0xffFF8C00);

//todo: move to a separate widget and localize snackbar

Widget kEnableLocationDialog(onConfirm) => PopScope(
      canPop: false,
      child: AlertDialog(
        backgroundColor: Get.isDarkMode ? const Color(0xff262424) : const Color(0xffEEEEDC),
        title: Text(
          'cant use the app'.tr,
          style: TextStyle(
            color: !Get.isDarkMode ? const Color(0xff666666) : const Color(0xffEEEEDC),
            fontSize: 20,
          ),
        ),
        content: Text(
          'please enable location services then press ok'.tr,
          style: TextStyle(
            color: !Get.isDarkMode ? const Color(0xff666666) : const Color(0xffEEEEDC),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Geolocator.openLocationSettings();
            },
            child: Text(
              "open settings".tr,
              style: TextStyle(
                color: !Get.isDarkMode ? const Color(0xff666666) : const Color(0xffEEEEDC),
              ),
            ),
          ),
          TextButton(
            onPressed: onConfirm,
            child: Text("ok".tr,
                style: TextStyle(
                  color: !Get.isDarkMode ? const Color(0xff666666) : const Color(0xffEEEEDC),
                )),
          ),
        ],
      ),
    );

kTimeOutSnackBar() => Get.snackbar(
      "لا يوجد اتصال بالانترنت",
      "تأكد من اتصالك أو حاول لاحقاً ",
      icon: const Padding(
        padding: EdgeInsets.only(right: 8),
        child: Icon(Icons.wifi_off, color: Colors.white),
      ),
      colorText: Colors.white,
      backgroundColor: Colors.red,
    );

kServerErrorSnackBar() => Get.snackbar(
      "الخادم لا يستجيب",
      "الرجاء المحاولة لاحقاً",
      icon: const Padding(
        padding: EdgeInsets.only(right: 8),
        child: Icon(Icons.storage, color: Colors.white),
      ),
      colorText: Colors.white,
      backgroundColor: Colors.deepOrangeAccent,
    );

TextTheme kMyTextTheme = TextTheme(
  displayLarge: TextStyle(
    fontSize: 57,
    //wordSpacing: 64,
    letterSpacing: 0,
    fontFamily: kFontFamily,
  ),
  displayMedium: TextStyle(
    fontSize: 45,
    //wordSpacing: 52,
    letterSpacing: 0,
    fontFamily: kFontFamily,
  ),
  displaySmall: TextStyle(
    fontSize: 36,
    //wordSpacing: 44,
    letterSpacing: 0,
    fontFamily: kFontFamily,
  ),
  headlineLarge: TextStyle(
    fontSize: 32,
    //wordSpacing: 40,
    letterSpacing: 0,
    fontFamily: kFontFamily,
  ),
  headlineMedium: TextStyle(
    fontSize: 28,
    //wordSpacing: 36,
    letterSpacing: 0,
    fontFamily: kFontFamily,
  ),
  headlineSmall: TextStyle(
    fontSize: 24,
    //wordSpacing: 32,
    letterSpacing: 0,
    fontFamily: kFontFamily,
  ),
  titleLarge: TextStyle(
    fontSize: 22,
    //wordSpacing: 28,
    letterSpacing: 0,
    fontFamily: kFontFamily,
  ),
  titleMedium: TextStyle(
    fontSize: 18,
    //wordSpacing: 24,
    letterSpacing: 0.15,
    fontFamily: kFontFamily,
  ),
  titleSmall: TextStyle(
    fontSize: 14,
    //wordSpacing: 20,
    letterSpacing: 0.1,
    fontFamily: kFontFamily,
  ),
  labelLarge: TextStyle(
    fontSize: 14,
    //wordSpacing: 20,
    letterSpacing: 0.1,
    fontFamily: kFontFamily,
  ),
  labelMedium: TextStyle(
    fontSize: 12,
    //wordSpacing: 16,
    letterSpacing: 0.5,
    fontFamily: kFontFamily,
  ),
  labelSmall: TextStyle(
    fontSize: 11,
    //wordSpacing: 16,
    letterSpacing: 0.5,
    fontFamily: kFontFamily,
  ),
  bodyLarge: TextStyle(
    fontSize: 16,
    //wordSpacing: 24,
    letterSpacing: 0.15,
    fontFamily: kFontFamily,
  ),
  bodyMedium: TextStyle(
    fontSize: 14,
    //wordSpacing: 20,
    letterSpacing: 0.25,
    fontFamily: kFontFamily,
  ),
  bodySmall: TextStyle(
    fontSize: 12,
    //wordSpacing: 16,
    letterSpacing: 0.4,
    fontFamily: kFontFamily,
  ),
);
