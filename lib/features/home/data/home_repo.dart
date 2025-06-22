// ignore_for_file: avoid_print

import 'package:ajalah/core/utils/error_utils.dart';
import 'package:ajalah/shared/models/brand_model.dart';
import 'package:ajalah/shared/models/car_card_model.dart';
import '../../../core/network/api_provider.dart';
import '../../../core/services/storage_service.dart';

class HomeRepository {
  final ApiProvider apiProvider;
  final StorageService storageService;
  List<CarCardItem>? _cachedNewCars;
  DateTime? _newCarsCacheTime;
  List<CarCardItem>? _cachedImportedCars;
  DateTime? _importedCarsCacheTime;
  List<CarCardItem>? _cachedLatestCars;
  DateTime? _latestCarsCacheTime;
  List<BrandModel>? _cachedBrands;
  DateTime? _brandsCacheTime;
  HomeRepository({required this.apiProvider, required this.storageService});

  Future<List<CarCardItem>> fetchNewCars() async {
    const cacheDuration = Duration(minutes: 3);
    if (_cachedNewCars != null &&
        _newCarsCacheTime != null &&
        DateTime.now().difference(_newCarsCacheTime!) < cacheDuration) {
      return _cachedNewCars!;
    }
    try {
      final response = await apiProvider.client.get('/vehicle/new?limit=4');
      final dataList = response.data['data'] as List<dynamic>;
      final newCars = dataList
          .map((e) => CarCardItem.fromJson(e as Map<String, dynamic>))
          .toList();
      _cachedNewCars = newCars;
      _newCarsCacheTime = DateTime.now();
      return newCars;
    } catch (e) {
      final errorMessage = ErrorUtils.parseDioError(e);

      throw errorMessage;
    }
  }

  Future<List<CarCardItem>> fetchimportedCars() async {
    const cacheDuration = Duration(minutes: 3);
    if (_cachedImportedCars != null &&
        _importedCarsCacheTime != null &&
        DateTime.now().difference(_importedCarsCacheTime!) < cacheDuration) {
      return _cachedImportedCars!;
    }
    try {
      final response = await apiProvider.client.get(
        '/imported-vehicle?limit=4',
      );
      print('respons $response');
      final dataList = response.data['data'] as List<dynamic>;
      final importedCars = dataList
          .map((e) => CarCardItem.fromJson(e as Map<String, dynamic>))
          .toList();
      _cachedImportedCars = importedCars;
      _importedCarsCacheTime = DateTime.now();
      return importedCars;
    } catch (e) {
      final errorMessage = ErrorUtils.parseDioError(e);

      throw errorMessage;
    }
  }

  Future<List<CarCardItem>> fetchLatestCars() async {
    const cacheDuration = Duration(minutes: 3);
    if (_cachedLatestCars != null &&
        _latestCarsCacheTime != null &&
        DateTime.now().difference(_latestCarsCacheTime!) < cacheDuration) {
      return _cachedLatestCars!;
    }
    try {
      final response = await apiProvider.client.get('/vehicle/latest?limit=4');
      print('respons $response');
      final dataList = response.data['data'] as List<dynamic>;
      final latestCars = dataList
          .map((e) => CarCardItem.fromJson(e as Map<String, dynamic>))
          .toList();
      _cachedLatestCars = latestCars;
      _latestCarsCacheTime = DateTime.now();
      return latestCars;
    } catch (e) {
      final errorMessage = ErrorUtils.parseDioError(e);

      throw errorMessage;
    }
  }

  Future<List<BrandModel>> fetchbrands() async {
    const cacheDuration = Duration(minutes: 10);
    if (_cachedBrands != null &&
        _brandsCacheTime != null &&
        DateTime.now().difference(_brandsCacheTime!) < cacheDuration) {
      return _cachedBrands!;
    }
    try {
      final response = await apiProvider.client.get('/brand/find-all');
      print('respons $response');
      final data = response.data['data'] as Map<String, dynamic>;
      final dataList = data['brands'] as List<dynamic>;

      final brands = dataList
          .map((e) => BrandModel.fromJson(e as Map<String, dynamic>))
          .toList();
      _cachedBrands = brands;
      _newCarsCacheTime = DateTime.now();
      return brands;
    } catch (e) {
      final errorMessage = ErrorUtils.parseDioError(e);

      throw errorMessage;
    }
  }

  Future<CarCardItem> handleSave(String id, String ownerRole) async {
    try {
      final response = await apiProvider.client.post(
        '/saved-vehicles',
        data: (ownerRole != 'imported')
            ? {"vehicleId": id}
            : {"vehicleId": id, "type": "imported"},
      );
      final data = response.data['data'];
      return CarCardItem.fromJson(data);
    } catch (e) {
      final errorMessage = ErrorUtils.parseDioError(e);

      throw errorMessage;
    }
  }

  Future<CarCardItem> handleUnSave(
    String? savedVehicleId,
    String? ownerRole,
  ) async {
    try {
      print('ownerRole: $ownerRole');
      final response = await apiProvider.client.delete(
        '/saved-vehicles/$savedVehicleId',
      );
      final data = response.data['data'];

      return CarCardItem.fromJson(data);
    } catch (e) {
      final errorMessage = ErrorUtils.parseDioError(e);

      throw errorMessage;
    }
  }
}
