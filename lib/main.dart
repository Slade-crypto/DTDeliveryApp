import 'dart:io';

import 'package:dt_delivery_app/app/core/config/http_override.dart';
import 'package:dt_delivery_app/app/dw_delivery_app.dart';
import 'package:flutter/material.dart';

import 'app/core/config/env/env.dart';

void main() async {
  await Env.i.load();
  HttpOverrides.global = HttpOverride();
  runApp(DwDeliveryApp());
}
