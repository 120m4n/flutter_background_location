import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

final sl = GetIt.instance;

class InjectionContainer extends Injector {}

abstract class Injector {
  @mustCallSuper
  Future<void> init() async {
    sl.registerSingleton<Box<String>>(await Hive.openBox<String>('locations'));
  }
}