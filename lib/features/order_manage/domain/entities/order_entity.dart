import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final String? user_id;
  final String? cooking_instructions;
  final String? delivery_address;
  final GeoPoint? delivery_location;
  final String? driver_id;
  final bool? is_completed;
  final bool? is_dispatched;
  final bool? order_accept_by_driver;
  final bool? order_accept_by_restaurant;
  final String? order_id;
  final Timestamp? order_time;
  final String? payment_method;
  final String? restaurant_id;
  final String? total_amount;
  final bool? is_rejected;
  final String? driver_name;
  final String? driver_number;
  final String? restaurant_name;
  final String? restaurant_address;
  final num? restaurant_rating;
  final List<dynamic> items;
  final String? user_name;
  final String? user_mobile;
  final GeoPoint? restaurant_location;

  const OrderEntity(
      {required this.driver_name,
      required this.driver_number,
      this.restaurant_name,
      this.user_id,
      this.cooking_instructions,
      required this.delivery_address,
      this.restaurant_location,
      this.delivery_location,
      this.driver_id,
      this.restaurant_address,
      this.restaurant_rating,
      required this.is_completed,
      required this.is_dispatched,
      required this.order_accept_by_driver,
      required this.order_accept_by_restaurant,
      required this.order_id,
      this.order_time,
      this.payment_method,
      this.restaurant_id,
      required this.total_amount,
      required this.is_rejected,
      required this.items,
      this.user_name,
      this.user_mobile});

  @override
  List<Object?> get props => [
        user_id,
        user_name,
        driver_number,
        user_mobile,
        driver_name,
        cooking_instructions,
        restaurant_rating,
        delivery_address,
        delivery_location,
        items,
        restaurant_address,
        restaurant_location,
        driver_id,
        restaurant_name,
        is_completed,
        is_dispatched,
        order_accept_by_driver,
        order_accept_by_restaurant,
        order_id,
        order_time,
        payment_method,
        restaurant_id,
        total_amount,
        is_rejected,
      ];
}
