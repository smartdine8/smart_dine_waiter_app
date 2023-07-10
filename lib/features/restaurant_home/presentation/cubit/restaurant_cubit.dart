import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smartdine_waiter/features/order_manage/data/models/order_item_model.dart';
import 'package:smartdine_waiter/features/order_manage/data/models/order_model.dart';
import 'package:smartdine_waiter/features/restaurant_home/data/models/restaurant_menu_item_model.dart';
import 'package:smartdine_waiter/features/restaurant_home/data/models/restaurant_model.dart';
import 'package:smartdine_waiter/features/restaurant_home/domain/use_cases/fetch_restaurant_menu_usecase.dart';
import 'package:smartdine_waiter/features/restaurant_home/domain/use_cases/fetch_restaurant_usecase.dart';

part 'restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  final GetRestaurantUseCase getRestaurantUseCase;
  final GetRestaurantMenuUseCase getRestaurantMenuUseCase;

  RestaurantCubit(
      {required this.getRestaurantUseCase,
      required this.getRestaurantMenuUseCase,
     })
      : super(RestaurantInitial());

  List<RestaurantMenuItemModel> restaurantMenu = [];
  late StreamSubscription<List<RestaurantMenuItemModel>> getRestaurantMenu;
  List<OrderItemModel> orderItemList = [];

  getRestaurantDetails() async {
    try {
      emit(RestaurantLoading());
      final RestaurantModel restaurant = await getRestaurantUseCase.call();
      late List<String> categories = [];

      var restaurantMenuItemStream = getRestaurantMenuUseCase.call();

      getRestaurantMenu = restaurantMenuItemStream.listen((menu) {
        restaurantMenu = menu;
        categories = menu.map((e) => e.foodCategory!).toSet().toList();

        emit(RestaurantLoaded(
            restaurant: restaurant,
            restaurantMenuItems: restaurantMenu,
            categories: categories));
      });
    } catch (e) {
      throw Exception("Error while fetching restaurants.");
    }
  }

  void updateOrderItem(List<OrderItemModel> items, String itemName) {
    items.forEach((item) {
      orderItemList.removeWhere(
          (element) => element.order_item_name == item.order_item_name);

      orderItemList.add(item);
    });

    if (items.isEmpty) {
      orderItemList
          .removeWhere((element) => element.order_item_name == itemName);
    }

    if (state is RestaurantLoaded) {
      OrderModel orderModel = OrderModel(
        is_delivered: false,
        items: orderItemList,
      );

      RestaurantLoaded newState = (state as RestaurantLoaded).copyWith(
          orderModel: orderModel, update: !(state as RestaurantLoaded).update);

      emit(newState);
    }
  }
}
