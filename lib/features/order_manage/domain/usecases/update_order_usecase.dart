import 'package:smartdine_waiter/features/order_manage/data/models/order_model.dart';
import 'package:smartdine_waiter/features/order_manage/domain/entities/order_entity.dart';

import '../repositories/order_manage_repository.dart';

class UpdateOrderUseCase {
  final OrderManageRepository orderManageRepository;

  UpdateOrderUseCase({required this.orderManageRepository});

  Future<void> call(OrderModel orderEntity) {
    return orderManageRepository.updateOrder(orderEntity);
  }
}
