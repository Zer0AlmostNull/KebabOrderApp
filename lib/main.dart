import 'screens/menuScreen.dart';
import 'package:flutter/material.dart';

import 'dart:io';
import 'package:flutter/services.dart';
import 'config/colors.dart';

// FONTS
import 'package:google_fonts/google_fonts.dart';

// LICENCES
import 'package:flutter/foundation.dart';

// SPLASH
import 'package:flutter_native_splash/flutter_native_splash.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // make sure screen wont rotate
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // keep loading screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // connestion stuff
  HttpOverrides.global = MyHttpOverrides();
  ByteData data = await rootBundle.load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());

  // add fonts licenses
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL_Oswald.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  // remove loading screen
  FlutterNativeSplash.remove();

  runApp(
    MaterialApp(
      title: 'Kebab',
      home: const RootScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: mainColor,
        textTheme: GoogleFonts.oswaldTextTheme(),
        appBarTheme: const AppBarTheme(
          backgroundColor: mainColor,
        ),
      ),
    ),
  );
}
