import 'package:dt_delivery_app/app/core/provider/application_bindings.dart';
import 'package:dt_delivery_app/app/core/ui/theme/theme_config.dart';
import 'package:dt_delivery_app/app/pages/home/home_router.dart';
import 'package:dt_delivery_app/app/pages/product_detail/product_detail_router.dart';
import 'package:dt_delivery_app/app/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';

class DwDeliveryApp extends StatelessWidget {
  const DwDeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ApplicationBindings(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Delivery app',
        theme: ThemeConfig.theme,
        routes: {
          '/': (context) => const SplashPage(),
          '/home': (context) => HomeRouter.page,
          '/productDetail': (context) => ProductDetailRouter.page,
        },
      ),
    );
  }
}
