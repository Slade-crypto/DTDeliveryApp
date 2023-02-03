import 'dart:js';

import 'package:dt_delivery_app/app/pages/order/order_controller.dart';
import 'package:dt_delivery_app/app/pages/order/order_page.dart';
import 'package:dt_delivery_app/app/repositories/order/order_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderRouter {
  OrderRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(
            create: (context) => OrderController(
              context.read(),
            ),
          ),
          Provider(
            create: (context) => OrderRepositoryImpl(
              dio: context.read(),
            ),
          ),
        ],
        child: const OrderPage(),
      );
}
