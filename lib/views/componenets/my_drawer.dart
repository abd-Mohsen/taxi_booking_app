import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/locale_controller.dart';
import '../../controllers/theme_controller.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;

    ThemeController tC = Get.find();
    LocaleController lC = Get.find();

    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      backgroundColor: cs.secondaryContainer,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              "user",
              style: tt.titleMedium!.copyWith(color: cs.onPrimary),
            ),
            accountEmail: Text(
              "user@gmail.com",
              style: tt.titleSmall!.copyWith(color: cs.onPrimary),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.dark_mode_outlined,
                      size: 25,
                      color: cs.primary,
                    ),
                    title: Text(
                      "dark mode".tr,
                      style: tt.labelLarge!.copyWith(color: cs.onSurface),
                    ),
                    trailing: Switch(
                      value: tC.switchValue,
                      onChanged: (bool value) {
                        tC.updateTheme(!tC.switchValue);
                      },
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.language,
                    size: 25,
                    color: cs.primary,
                  ),
                  title: DropdownButton(
                    elevation: 10,
                    iconEnabledColor: cs.onSurface,
                    dropdownColor: Colors.grey[300],
                    hint: Text(
                      lC.getCurrentLanguageLabel(),
                      style: tt.labelMedium!.copyWith(color: cs.onSurface),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: "ar",
                        child: Text(
                          "Arabic".tr,
                          style: tt.labelLarge!.copyWith(color: Colors.black),
                        ),
                      ),
                      DropdownMenuItem(
                        value: "en",
                        child: Text(
                          "English".tr,
                          style: tt.labelLarge!.copyWith(color: Colors.black),
                        ),
                      ),
                    ],
                    onChanged: (val) {
                      lC.updateLocale(val!);
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              "${"all rights reserved".tr} ®",
              style: tt.labelSmall!.copyWith(color: cs.onSurface.withValues(alpha: 0.6)),
            ),
          ),
        ],
      ),
    );
  }
}
