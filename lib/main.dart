import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'views/view.dart';
import 'utils/util.dart';
import 'viewmodels/viewmodel.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CategoryViewModel>(
          create: (_) => CategoryViewModel(),
        ),
        ChangeNotifierProvider<ProductViewModel>(
          create: (__) => ProductViewModel(),
        ),
        ChangeNotifierProvider<UserViewModel>(
          create: (___) => UserViewModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Litemall App',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Global.firstColor,
            titleTextStyle: GoogleFonts.dmSans(
              fontWeight: FontWeight.bold,
              color: Global.thirdColor,
              fontSize: 18,
            ),
            iconTheme: const IconThemeData(
              color: Global.thirdColor,
            ),
          ),
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
              TargetPlatform.iOS: OpenUpwardsPageTransitionsBuilder(),
            },
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const RootView(),
        debugShowCheckedModeBanner: false,
        routes: Global.routes,
        onGenerateRoute: Global.onGenerateRoute,
      ),
    );
  }
}
