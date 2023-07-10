import 'package:smartdine_waiter/features/restaurant_home/data/models/restaurant_model.dart';
import 'package:smartdine_waiter/features/restaurant_home/domain/repositories/restaurant_repository.dart';

class GetRestaurantUseCase {
  final RestaurantRepository restaurantRepository;

  GetRestaurantUseCase({required this.restaurantRepository});

  Future<RestaurantModel> call() {
    return restaurantRepository.getRestaurant();
  }
}
