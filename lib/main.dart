import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:taxi_booking_app/themes.dart';
import 'package:taxi_booking_app/views/home_page.dart';
import 'api.dart';
import 'controllers/locale_controller.dart';
import 'controllers/theme_controller.dart';
import 'locale.dart';

Api api = Api();

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeController t = Get.put(ThemeController());
    LocaleController l = Get.put(LocaleController());
    return GetMaterialApp(
      translations: MyLocale(),
      locale: l.initialLang,
      title: 'Camion',
      home: const HomePage(),
      theme: MyThemes.myLightMode, //custom light theme
      darkTheme: MyThemes.myDarkMode, //custom dark theme
      themeMode: t.getThemeMode(),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(devicePixelRatio: 1, textScaler: const TextScaler.linear(1)),
          child: child!,
        );
      },
    );
  }
}
