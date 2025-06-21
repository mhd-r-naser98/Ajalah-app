import 'package:flutter/material.dart';
import '../app/app.dart';
import '../core/di/service_locator.dart';
import '../core/services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storageService = await SecureStorageService.create();
  await setupCoreServices(storageService);

  runApp(const App());
}
