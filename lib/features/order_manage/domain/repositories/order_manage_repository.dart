import 'package:smartdine_waiter/features/order_manage/data/models/order_model.dart';

abstract class OrderManageRepository {
  Stream<List<OrderModel>> orderListStream();
  Future<void> addOrder(OrderModel orderModel);
  Future<void> updateOrder(OrderModel orderModel);
}
