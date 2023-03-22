import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'database/favorite_images.dart';
import 'style.dart';
import 'router/app_router.gr.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final applicatonDocumentDir =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(applicatonDocumentDir.path);

  Hive.registerAdapter(FavoriteBox());
  await Hive.openBox<FavoriteImage>(
    'FavoriteBox',
  );

  await Hive.initFlutter();

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  final appRouter = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, screenUtil) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: Style.mainTheme,
          routeInformationParser: appRouter.defaultRouteParser(),
          routerDelegate: appRouter.delegate(),
          // darkTheme: Style.darkTheme(context),
          // showSemanticsDebugger: false,
        );
      },
    );
  }
}
