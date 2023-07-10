import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smartdine_waiter/features/order_manage/data/models/order_item_model.dart';
import 'package:smartdine_waiter/features/order_manage/data/models/order_model.dart';
import 'package:smartdine_waiter/features/order_manage/domain/usecases/add_order_usecase.dart';
import 'package:smartdine_waiter/features/order_manage/domain/usecases/update_order_usecase.dart';

import '../../domain/usecases/get_order_list_usecase.dart';

part 'order_manage_state.dart';

class OrderManageCubit extends Cubit<OrderManageState> {
  final GetOrderListUseCase getOrderListUseCase;
  final AddOrderUseCase addOrderUseCase;
  final UpdateOrderUseCase updateOrderUseCase;

  OrderManageCubit(
      {required this.addOrderUseCase,
      required this.getOrderListUseCase,
      required this.updateOrderUseCase})
      : super(OrderManageInitial());

  getOrderList() async {
    try {
      emit(OrderManageLoading());
      final Stream<List<OrderModel>> orderList =
          getOrderListUseCase.orderManageRepository.orderListStream(); //uid
      orderList.listen((event) async {
        if (event.isEmpty) {
          emit(const OrderManageFailed(message: 'No Order Available'));
        } else {
          emit(OrderManageLoaded(listOrder: event));
        }
      });
    } catch (e) {
      emit(OrderManageFailed(message: e.toString()));
    }
  }

  addOrder(List<OrderItemModel> orderItems, String selectedTableId,
      String slectedTableName) async {
    late int totalAmount = 0;
    try {
      List<int> amounts = orderItems
          .map((e) => e.order_item_price * e.order_item_quantity)
          .toList();

      totalAmount = amounts.reduce((v, e) => v + e);

      await addOrderUseCase.orderManageRepository.addOrder(OrderModel(
        items: orderItems,
        total_amount: totalAmount,
        table_id: selectedTableId,
        order_delivered_by: '',
        table_name: slectedTableName,
        orderPlaceAt: DateTime.now(),
      ));
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  updateOrder(OrderModel order) {
    updateOrderUseCase.call(order);
  }
}
