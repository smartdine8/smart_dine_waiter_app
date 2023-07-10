import 'package:smartdine_waiter/features/restaurant_home/data/models/restaurant_menu_item_model.dart';
import 'package:smartdine_waiter/features/restaurant_home/data/models/restaurant_model.dart';

abstract class RestaurantDataSource {
  Future<RestaurantModel> getRestaurant();
  Stream<List<RestaurantMenuItemModel>> getRestaurantMenu();
}
