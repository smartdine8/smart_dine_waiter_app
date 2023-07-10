import 'package:smartdine_waiter/features/restaurant_home/data/data_sources/restaurant_data_source.dart';
import 'package:smartdine_waiter/features/restaurant_home/data/models/restaurant_menu_item_model.dart';
import 'package:smartdine_waiter/features/restaurant_home/data/models/restaurant_model.dart';
import 'package:smartdine_waiter/features/restaurant_home/domain/repositories/restaurant_repository.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantDataSource restaurantDataSource;

  RestaurantRepositoryImpl({required this.restaurantDataSource});

  @override
  Future<RestaurantModel> getRestaurant() {
    return restaurantDataSource.getRestaurant();
  }

  @override
  Stream<List<RestaurantMenuItemModel>> getRestaurantMenu() {
    return restaurantDataSource.getRestaurantMenu();
  }
}
