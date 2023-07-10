part of 'order_manage_cubit.dart';

abstract class OrderManageState extends Equatable {
  const OrderManageState();
}

class OrderManageInitial extends OrderManageState {
  @override
  List<Object> get props => [];
}

class OrderManageLoading extends OrderManageState {
  @override
  List<Object> get props => [];
}

class OrderManageLoaded extends OrderManageState {
  final List<OrderModel> listOrder;

  const OrderManageLoaded({required this.listOrder});

  @override
  List<Object> get props => [listOrder];
}

class OrderManageFailed extends OrderManageState {
  final String message;

  const OrderManageFailed({required this.message});

  @override
  List<Object?> get props => [message];
}
