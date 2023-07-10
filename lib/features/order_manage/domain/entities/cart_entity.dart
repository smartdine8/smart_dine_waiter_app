import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';


class CartDetailEntity extends Equatable {
  final bool? is_available;
  final bool? is_vegetarian;
  final int? item_discount;
  final String? item_name;
  final String? item_image;
  final int? item_quantity;
  final int? item_price;
  final String? item_state;
  final String? restaurant_id;
  final DocumentReference? item_ref;
   CartDetailEntity(
      {this.is_available,
      this.is_vegetarian,
      this.item_discount,
      this.item_name,
      this.item_image,
      this.item_price,
      this.item_state,
      this.restaurant_id,
      this.item_ref,
      this.item_quantity});
  @override
  // TODO: implement props
  List<Object?> get props =>[
    is_available,
    is_vegetarian,
    item_discount,
    item_name,
    item_image,
    item_price,
    item_state,
    restaurant_id,
    item_ref,
    item_quantity
  ];


}