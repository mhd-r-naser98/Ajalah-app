import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<dynamic> cars;
  const HomeLoaded({required this.cars});
}

class HomeFailure extends HomeState {
  final String error;
  const HomeFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
