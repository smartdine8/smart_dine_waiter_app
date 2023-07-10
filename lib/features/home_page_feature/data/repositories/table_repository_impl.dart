import '../../../../core/data_sources/remote/firebase/common_firestore_datasource.dart';
import '../../domain/repository/table_repository.dart';
import '../model/waiter_table.dart';

class TableRepositoryImpl implements TableRepository {
  final CommonFirestoreDatasource commonFirestoreDatasource;

  TableRepositoryImpl({required this.commonFirestoreDatasource});

  @override
  Stream<List<WaiterTable>> getTableList() {
    return commonFirestoreDatasource.collectionStream(
      path: 'tables',
      builder: (data, ref) {
        return WaiterTable.fromMap(data);
      },
    );
  }
}
