import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:q_movies/core/qcolors.dart';
import 'package:q_movies/routes/app_pages.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: QColors.navColor,
    ),
  );

  await Hive.initFlutter();
  // final boxCacheData = await Hive.openBox('boxCacheData');

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, widget) {
        return GetMaterialApp(
          initialRoute: Routes.HOME_SCREEN,
          getPages: AppPages.routes,
          defaultTransition: Transition.noTransition,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'SF-Pro-Display',
          ),
        );
      },
    );
  }
}
