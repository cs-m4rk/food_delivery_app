import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/models/restaurant.dart';
import 'package:food_delivery_app/screens/onboarding_screen.dart';
import 'package:food_delivery_app/services/auth/auth_gate.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:food_delivery_app/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Restaurant()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: GetMaterialApp(
            title: 'Moodeng Delivery App',
            debugShowCheckedModeBanner: false,
            scrollBehavior: const ScrollBehavior()
                .copyWith(physics: const BouncingScrollPhysics()),
            defaultTransition: Transition.fadeIn,
            locale: const Locale('en_US'),
            onGenerateRoute: AppRoutes.generateRoute,
            home: const AuthGate(),
            theme: ThemeData(
              fontFamily: 'Poppins',
            ),
          ),
        );
      },
    );
  }
}
