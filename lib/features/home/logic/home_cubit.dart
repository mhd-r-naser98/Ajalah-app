import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> fetchCars() async {
    emit(HomeLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));

      emit(HomeLoaded());
    } catch (e) {
      emit(HomeFailure(error: e.toString()));
    }
  }
}
