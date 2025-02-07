import 'package:desktop_adb_file_browser/pages/ADBCheck.dart';
import 'package:desktop_adb_file_browser/pages/browser.dart';
import 'package:desktop_adb_file_browser/pages/devices.dart';
import 'package:desktop_adb_file_browser/pages/logger.dart';
import 'package:desktop_adb_file_browser/pigeon_impl.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:routemaster/routemaster.dart';

final routes = RouteMap(routes: {
  '/': (_) => const MaterialPage(
      key: ValueKey("adbcheck"),
      child: ADBCheck(
        redirectPage: '/devices',
      )),

  '/devices': (_) =>
      const MaterialPage(key: ValueKey("devices"), child: DevicesPage()),

  '/browser/:device/:path': (info) => MaterialPage(
      key: const ValueKey("browser"),
      child: DeviceBrowser(
        serial: info.pathParameters['device']!,
        initialAddress: info.pathParameters['path']!,
      )),
  '/log/:device': (info) => MaterialPage(
      key: const ValueKey("log"),
      child: LogPage(
        serial: info.pathParameters['device']!,
      ))

  // '/feed': (_) => MaterialPage(child: FeedPage()),
  // '/settings': (_) => MaterialPage(child: SettingsPage()),
  // '/feed/profile/:id': (info) => MaterialPage(
  //     child: ProfilePage(id: info.pathParameters['id'])
  // ),
});

late Native2FlutterImpl native2flutter;

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  runApp(const MyApp());
  debugPrint("Pigeon");
  native2flutter = Native2FlutterImpl();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: RoutemasterDelegate(routesBuilder: (context) => routes),
      routeInformationParser: const RoutemasterParser(),

      title: 'ADB File Manager',
      // https://rydmike.com/flexcolorschemeV4Tut5/#/
      // This theme was made for FlexColorScheme version 6.1.1. Make sure
      // you use same or higher version, but still same major version. If
      // you use a lower version, some properties may not be supported. In
      // that case you can also remove them after copying the theme to your app.
      theme: lightTheme(),
      darkTheme: darkTheme(),
      // If you do not have a themeMode switch, uncomment this line
      // to let the device system mode control the theme mode:
      // themeMode: ThemeMode.system,
      themeMode: ThemeMode.dark,
      // theme: ThemeData(
      //   // This is the theme of your application.
      //   //
      //   // Try running your application with "flutter run". You'll see the
      //   // application has a blue toolbar. Then, without quitting the app, try
      //   // changing the primarySwatch below to Colors.green and then invoke
      //   // "hot reload" (press "r" in the console where you ran "flutter run",
      //   // or simply save your changes to "hot reload" in a Flutter IDE).
      //   // Notice that the counter didn't reset back to zero; the application
      //   // is not restarted.
      //   primarySwatch: Colors.blue,
      // ),
    );
  }

  ThemeData lightTheme() {
    return FlexThemeData.light(
      scheme: FlexScheme.sanJuanBlue,
      surfaceMode: FlexSurfaceMode.highScaffoldLevelSurface,
      blendLevel: 9,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 10,
        blendOnColors: false,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      // To use the playground font, add GoogleFonts package and uncomment
      // fontFamily: GoogleFonts.notoSans().fontFamily,
    );
  }

  ThemeData darkTheme() {
    return FlexThemeData.dark(
      scheme: FlexScheme.sanJuanBlue,
      surfaceMode: FlexSurfaceMode.highScaffoldLevelSurface,
      blendLevel: 15,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 20,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      // To use the Playground font, add GoogleFonts package and uncomment
      // fontFamily: GoogleFonts.notoSans().fontFamily,
    );
  }
}
