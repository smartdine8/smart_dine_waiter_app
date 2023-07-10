part of 'restaurant_cubit.dart';

abstract class RestaurantState extends Equatable {
  const RestaurantState();
}

class RestaurantInitial extends RestaurantState {
  @override
  List<Object> get props => [];
}

class RestaurantLoading extends RestaurantState {
  @override
  List<Object> get props => [];
}

class RestaurantLoaded extends RestaurantState {
  final RestaurantModel restaurant;
  final List<RestaurantMenuItemModel> restaurantMenuItems;
  final List<String> categories;
  OrderModel? orderModel;
  bool update;

  RestaurantLoaded(
      {required this.restaurant,
      required this.restaurantMenuItems,
      required this.categories,
      this.orderModel,
      this.update = false});
  @override
  List<Object?> get props => [
        restaurant,
        restaurantMenuItems,
        categories,
        orderModel,
        update,
      ];

  RestaurantLoaded copyWith({
    RestaurantModel? restaurant,
    List<RestaurantMenuItemModel>? restaurantMenuItems,
    List<String>? categories,
    OrderModel? orderModel,
    bool? update,
  }) {
    return RestaurantLoaded(
      restaurant: restaurant ?? this.restaurant,
      restaurantMenuItems: restaurantMenuItems ?? this.restaurantMenuItems,
      categories: categories ?? this.categories,
      orderModel: orderModel ?? this.orderModel,
      update: update ?? this.update,
    );
  }
}

class RestaurantMenuState extends RestaurantState {
  const RestaurantMenuState();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class RestaurantMenuInitial extends RestaurantState {
  @override
  List<Object> get props => [];
}

class RestaurantMenuLoading extends RestaurantState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class RestaurantMenuLoaded extends RestaurantState {
  final RestaurantMenuItemModel restaurantMenuItem;

  const RestaurantMenuLoaded({required this.restaurantMenuItem});

  @override
  // TODO: implement props
  List<Object?> get props => [restaurantMenuItem];
}

class RestaurantMenuFailed extends RestaurantState {
  final String message;

  const RestaurantMenuFailed({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
