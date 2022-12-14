import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:q_movies/core/qcolors.dart';
import 'package:q_movies/models/cache_hive.dart';
import 'package:q_movies/models/genre.dart';
import 'package:q_movies/models/movie.dart';
import 'package:q_movies/routes/app_pages.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: QColors.navColor,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive
    ..registerAdapter(CacheHiveAdapter())
    ..registerAdapter(MovieAdapter())
    ..registerAdapter(GenreAdapter());
  await Hive.openBox<CacheHive>('cacheHive');
  await Hive.openBox<Movie>('favourites');

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
