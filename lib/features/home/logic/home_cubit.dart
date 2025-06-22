import 'package:ajalah/core/di/service_locator.dart';
import 'package:ajalah/features/home/data/home_repo.dart';
import 'package:ajalah/shared/models/brand_model.dart';
import 'package:ajalah/shared/models/car_card_model.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeRepository repository = locator<HomeRepository>();
  List<CarCardItem>? newCars;
  // final List<CarCardItem> rentCars;
  List<CarCardItem>? importCars;
  List<CarCardItem>? popularCars;
  List<BrandModel>? brands;
  HomeCubit() : super(HomeInitial());

  Future<void> fetchHomeData() async {
    emit(HomeLoading());

    try {
      newCars = await repository.fetchNewCars();
      importCars = await repository.fetchimportedCars();
      popularCars = await repository.fetchLatestCars();
      brands = await repository.fetchbrands();

      emit(
        HomeInitial(
          newCars: newCars,
          // rentCars: rentCars,
          importCars: importCars,
          popularCars: popularCars,
          brands: brands,
        ),
      );
      emit(HomeLoaded());
    } catch (e) {
      emit(HomeFailure(error: e.toString()));
    }
  }

  Future<CarCardItem> handleSave(String id, String ownerRole) async {
    try {
      final saveRes = await repository.handleSave(id, ownerRole);

      return saveRes;
    } catch (e) {
      emit(HomeFailure(error: e.toString()));
      throw Exception(e.toString());
    }
  }

  Future<CarCardItem> handleUnSave(
    String? savedVehicleId,
    String? ownerRole,
  ) async {
    try {
      final saveRes = await repository.handleUnSave(savedVehicleId, ownerRole);

      return saveRes;
    } catch (e) {
      emit(HomeFailure(error: e.toString()));
      throw Exception(e.toString());
    }
  }
}
