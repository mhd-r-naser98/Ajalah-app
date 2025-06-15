import 'package:flutter/material.dart';
import 'package:new_ajalah/app/app.dart';
import 'package:new_ajalah/core/di/service_locator.dart';
import 'package:new_ajalah/core/services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storageService = await SecureStorageService.create();
  await setupCoreServices(storageService);

  runApp(const App());
}
