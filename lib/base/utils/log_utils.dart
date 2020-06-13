import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  level: kReleaseMode ? Level.warning : Level.debug,
  printer: PrettyPrinter(colors: false, methodCount: 2),
);

//var loggerNoStack = Logger(
//  level: kReleaseMode ? Level.warning : Level.debug,
//  printer: PrettyPrinter(colors: false, methodCount: 0),
//);
