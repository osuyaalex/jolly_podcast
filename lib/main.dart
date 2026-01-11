import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jolly_podcast/backend/auth_provider.dart';
import 'package:jolly_podcast/backend/episodes_provider.dart';
import 'package:jolly_podcast/screens/splash/splash_screen.dart';
import 'package:jolly_podcast/utility/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart' as provider;




final GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  GoogleFonts.config.allowRuntimeFetching = true;

  runApp( provider.MultiProvider
    (
    providers: [
      provider.ChangeNotifierProvider<AuthProvider>(create:(_) => AuthProvider()),
      provider.ChangeNotifierProvider<EpisodesProvider>(create:(_) => EpisodesProvider()),
    ],
      child: MyApp()
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        ensureScreenSize: true,
        builder: (context,child) {
        return MaterialApp(
          navigatorKey: globalNavigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Jolly Podcast',
          theme:  IATheme.getLightTheme(),
          home: SplashScreen(),
        );
      }
    );
  }
}

