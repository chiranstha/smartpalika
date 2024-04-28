// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:newpalika/Riverpod/Model/gallery_model.dart';
import 'package:newpalika/Riverpod/Model/tax_model.dart';
import 'package:newpalika/Riverpod/Model/team_model.dart';
import 'package:newpalika/Riverpod/Model/wodapatramodel.dart';
import 'package:newpalika/Riverpod/Model/youtube_model.dart';
import 'package:newpalika/Views/welcomepage.dart';
import 'package:newpalika/services/app_navigator_service.dart';
import 'package:newpalika/services/fluronavigation.dart';
import 'Riverpod/Model/tax_details_model.dart';

Future<void> main() async {
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: mainColor, // status bar color
  // ));
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaxModelAdapter());
  Hive.registerAdapter(DetailAdapter());
  Hive.registerAdapter(WodaPatraModelAdapter());
  Hive.registerAdapter(TeamModelAdapter());
  Hive.registerAdapter(GalleryListAdapter());
  Hive.registerAdapter(YoutubeModelAdapter());

  await Hive.openBox<WodaPatraModel>('patras');
  await Hive.openBox<TaxModel>('taxs');
  await Hive.openBox<TeamModel>('members');
  await Hive.openBox<GalleryList>('photos');
  await Hive.openBox<YoutubeModel>('videos');
  await initialize();

  // runApp(
  //   DevicePreview(
  //     builder: (context) => const MyApp(),
  //   ),
  // );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final router = Routes.getRouter();

    return MaterialApp(
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: child!,
          );
        },
        debugShowCheckedModeBanner: false,
        onGenerateRoute: router.generator,
        navigatorKey: AppNavigatorService.navigatorKey,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const WelcomePage());
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
