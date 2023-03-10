import 'package:dt_delivery_app/app/core/global/global_context.dart';
import 'package:dt_delivery_app/app/core/provider/application_bindings.dart';
import 'package:dt_delivery_app/app/core/ui/theme/theme_config.dart';
import 'package:dt_delivery_app/app/pages/auth/login/login_router.dart';
import 'package:dt_delivery_app/app/pages/auth/register/register_router.dart';
import 'package:dt_delivery_app/app/pages/home/home_router.dart';
import 'package:dt_delivery_app/app/pages/order/order_completed_page.dart';
import 'package:dt_delivery_app/app/pages/order/order_router.dart';
import 'package:dt_delivery_app/app/pages/product_detail/product_detail_router.dart';
import 'package:dt_delivery_app/app/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';

class DwDeliveryApp extends StatelessWidget {
  final _navKey = GlobalKey<NavigatorState>();

  DwDeliveryApp({super.key}) {
    GlobalContext.i.navigatorKey = _navKey;
  }

  @override
  Widget build(BuildContext context) {
    return ApplicationBindings(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: _navKey,
        title: 'Delivery app',
        theme: ThemeConfig.theme,
        routes: {
          '/': (context) => const SplashPage(),
          '/home': (context) => HomeRouter.page,
          '/productDetail': (context) => ProductDetailRouter.page,
          '/auth/login': (context) => LoginRouter.page,
          '/auth/register': (context) => RegisterRouter.page,
          '/order': (context) => OrderRouter.page,
          '/order/completed': (context) => const OrderCompletedPage(),
        },
      ),
    );
  }
}
