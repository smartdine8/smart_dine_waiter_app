import '../../data/model/waiter_table.dart';

abstract class TableRepository {
  Stream<List<WaiterTable>> getTableList();
}
