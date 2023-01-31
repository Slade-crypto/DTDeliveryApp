import 'package:dt_delivery_app/app/pages/home/home_controller.dart';
import 'package:dt_delivery_app/app/pages/home/home_page.dart';
import 'package:dt_delivery_app/app/repositories/products_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../repositories/products_repository.dart';

class HomeRouter {
  HomeRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<ProductsRepository>(
            create: (context) => ProductsRepositoryImpl(
              dio: context.read(),
            ),
          ),
          Provider(
            create: (context) => HomeController(
              context.read(),
            ),
          ),
        ],
        child: const HomePage(),
      );
}
