import 'package:smartdine_waiter/features/order_manage/data/models/order_model.dart';

import '../entities/order_entity.dart';
import '../repositories/order_manage_repository.dart';

class GetOrderListUseCase {
  final OrderManageRepository orderManageRepository;

  GetOrderListUseCase({required this.orderManageRepository});

  Stream<List<OrderModel>> call() {
    return orderManageRepository.orderListStream();
  }
}
