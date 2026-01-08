import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_board/controllers/theme/theme_provider.dart';
import 'package:job_board/router/app_router_provider.dart';
import 'package:job_board/theme/dark_theme.dart';
import 'package:job_board/theme/light_theme.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51SH5qGLaQaSgNFuQrX5RepeUR4phmwJLSPi54PttJA5KcaishonEJLAWM1qXTIJVS38dxWGd0zUw8jj8H4YjNrG300tIHk00lk';
  await Stripe.instance.applySettings();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final router = ref.watch(routerProvider);
    return ScreenUtilInit(
      designSize: const Size(412, 915),
      builder: (context, child) {
        return MaterialApp.router(
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeState.themeMode,
          routerConfig: router,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
