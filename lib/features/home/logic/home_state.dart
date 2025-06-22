import 'package:ajalah/shared/models/brand_model.dart';
import 'package:ajalah/shared/models/car_card_model.dart';

abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {
  final List<CarCardItem>? newCars;
  // final List<CarCardItem> rentCars;
  final List<CarCardItem>? importCars;
  final List<CarCardItem>? popularCars;
  final List<BrandModel>? brands;

  HomeInitial({
    this.newCars,
    //  this.rentCars,
    this.importCars,
    this.popularCars,
    this.brands,
  });
}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {}

class HomeFailure extends HomeState {
  final String error;
  const HomeFailure({required this.error});
}
