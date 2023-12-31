import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'infrastructure/local/app_translations.dart';
import 'infrastructure/navigation/navigation.dart';
import 'infrastructure/navigation/routes.dart';
import 'infrastructure/theme/theme.dart';
import 'initializer.dart';

void main() async {
  await Initializer.init();
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Directionality(
          textDirection: TextDirection.ltr,
          child: EnvironmentsBadge(
            child: GetMaterialApp(
              initialRoute: Routes.splash,
              getPages: Nav.routes,
              debugShowCheckedModeBanner: false,
              theme: themeData,
              builder: (context, Widget? child) {
                final MediaQueryData data = MediaQuery.of(context);
                return MediaQuery(
                  data: data.copyWith(textScaleFactor: 1.1),
                  child: child!,
                );
              },
              supportedLocales: AppTranslations.locales,
              locale: AppTranslations.locale,
              fallbackLocale: AppTranslations.fallbackLocale,
              translations: AppTranslations(),
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
            ),
          ));
    });
  }
}

class EnvironmentsBadge extends StatelessWidget {
  final Widget child;

  const EnvironmentsBadge({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(child: child);
  }
}
