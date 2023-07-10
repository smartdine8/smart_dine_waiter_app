import 'package:smartdine_waiter/features/home_page_feature/domain/repository/table_repository.dart';

import '../../data/model/waiter_table.dart';

class FetchAllTablesUseCase {
  final TableRepository tableRepository;

  FetchAllTablesUseCase({required this.tableRepository});

  Stream<List<WaiterTable>> call() {
    return tableRepository.getTableList();
  }
}
