import 'package:smartdine_waiter/features/restaurant_home/data/models/restaurant_menu_item_model.dart';
import 'package:smartdine_waiter/features/restaurant_home/domain/repositories/restaurant_repository.dart';

class GetRestaurantMenuUseCase {
  final RestaurantRepository restaurantRepository;

  GetRestaurantMenuUseCase({required this.restaurantRepository});

  Stream<List<RestaurantMenuItemModel>> call() {
    return restaurantRepository.getRestaurantMenu();
  }
}
