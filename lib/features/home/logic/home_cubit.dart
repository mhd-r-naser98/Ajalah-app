// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'home_state.dart';

// class HomeCubit extends Cubit<HomeState> {
//   HomeCubit() : super(HomeInitial());

//   Future<void> fetchCars() async {
//     emit(HomeLoading());
//     try {
//       await Future.delayed(const Duration(seconds: 1));

//       emit(HomeLoaded());
//     } catch (e) {
//       emit(HomeFailure(error: e.toString()));
//     }
//   }
// }
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  List<dynamic>? _cachedCars; // كاش للسيارات

  Future<void> fetchCars({bool forceRefresh = false}) async {
    // إذا كانت البيانات موجودة في الكاش ولم يُطلب تحديث إجباري، استخدم الكاش
    if (_cachedCars != null && !forceRefresh) {
      emit(HomeLoaded(cars: _cachedCars!));
      return;
    }

    emit(HomeLoading());
    try {
      // هنا ضع منطق جلب البيانات الحقيقي من API أو قاعدة بيانات
      await Future.delayed(const Duration(seconds: 1));
      final cars = <dynamic>[]; // استبدلها بالبيانات الحقيقية

      _cachedCars = cars; // حفظ في الكاش
      emit(HomeLoaded(cars: cars));
    } catch (e) {
      emit(HomeFailure(error: 'حدث خطأ أثناء تحميل السيارات: ${e.toString()}'));
    }
  }

  void clearCache() {
    _cachedCars = null;
  }
}
