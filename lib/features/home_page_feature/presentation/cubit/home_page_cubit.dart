import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smartdine_waiter/features/home_page_feature/domain/use_cases/fetch_all_tables_usecase.dart';

import '../../data/model/waiter_table.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  final FetchAllTablesUseCase fetchAllRestaurantUseCase;

  HomePageCubit({required this.fetchAllRestaurantUseCase})
      : super(HomePageInitial());

  getAllRestaurantList() async {
    try {
      emit(HomePageLoading());
      final Stream<List<WaiterTable>> restList =
          fetchAllRestaurantUseCase.tableRepository.getTableList();
      restList.listen((event) async {
        if (event.isNotEmpty) {
          emit(HomePageLoaded(restList: event));
        }
      });
    } catch (e) {
      throw Exception("Error while fetching restaurants.");
    }
  }

  void updateSelectedTable(String tableId) {
    if (state is HomePageLoaded) {
      HomePageLoaded stateToEmit =
          (state as HomePageLoaded).copyWith(selectedTableId: tableId);
      emit(stateToEmit);
    }
  }
}
