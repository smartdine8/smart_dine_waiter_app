import '../../../../core/data_sources/remote/firebase/common_firestore_datasource.dart';

import '../../domain/repositories/order_manage_repository.dart';
import '../models/order_model.dart';

class OrderManageRepositoryImpl implements OrderManageRepository {
  final CommonFirestoreDatasource commonFirestoreDatasource;

  OrderManageRepositoryImpl({required this.commonFirestoreDatasource});


  @override
  Stream<List<OrderModel>> orderListStream() {
    return commonFirestoreDatasource.collectionStream(
      path: 'orders',
      builder: (data, ref) => OrderModel.fromMap(data),
      queryBuilder: (query) =>
          query.orderBy("order_placed_at", descending: true),
    );
  }

  @override
  Future<void> addOrder(OrderModel orderEntity) {
    var orderId = DateTime.now().microsecondsSinceEpoch.toString();

    OrderModel orderModel = orderEntity.cloneWith(order_id: orderId);

    return commonFirestoreDatasource
        .setData(path: "orders/$orderId", data: orderModel.toMap())
        .then((value) {
      commonFirestoreDatasource.updateData(
          path: "tables/${orderEntity.table_id}",
          data: {'is_occupied': true, 'is_order_placed': true});
    });
  }

  @override
  Future<void> updateOrder(OrderModel orderEntity) {
    return commonFirestoreDatasource.updateData(
        path: "orders/${orderEntity.order_id}",
        data: {
          "is_delivered": true,
          "order_delivered_at": DateTime.now()
        }).then((value) {
      commonFirestoreDatasource.updateData(
          path: "tables/${orderEntity.table_id}",
          data: {
            'is_occupied': false,
            'is_order_placed': false,
            'is_bill_paid': true
          });
    });
  }
}
