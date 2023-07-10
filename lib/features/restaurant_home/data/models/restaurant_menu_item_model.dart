import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class RestaurantMenuItemModel extends Equatable {
  final String? foodCategory;
  final bool? isVeg;
  final int? foodItemDiscount;
  final String? foodItemName;
  final String? foodItemDesc;
  final String? foodItemImage;
  final DocumentReference? documentReference;
  final int? foodItemPrice;

  const RestaurantMenuItemModel({
    this.foodCategory,
    this.isVeg,
    this.foodItemDiscount,
    this.foodItemName,
    this.foodItemDesc,
    this.foodItemImage,
    this.documentReference,
    this.foodItemPrice,
  });

  factory RestaurantMenuItemModel.fromMap(
      Map<String, dynamic> json, DocumentReference documentReference) {
    return RestaurantMenuItemModel(
      documentReference: documentReference,
      foodCategory: json["food_category"] ?? "",
      isVeg: json["is_veg"],
      foodItemDiscount: json["food_item_discount"] != null
          ? int.parse(json["food_item_discount"])
          : 0,
      foodItemName: json["food_item_name"] ?? "",
      foodItemImage: json["food_item_image"] ?? "",
      foodItemDesc: json["food_item_desc"] ?? "",
      foodItemPrice: json["food_item_price"] != null
          ? int.parse(json["food_item_price"])
          : 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "food_category": foodCategory,
      "is_veg": isVeg,
      "food_item_discount": foodItemDiscount,
      "food_item_name": foodItemName,
      "food_item_image": foodItemImage,
      "food_item_desc": foodItemDesc,
      "food_item_price": foodItemPrice,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        foodCategory,
        isVeg,
        foodItemDiscount,
        foodItemName,
        foodItemDesc,
        foodItemImage,
        documentReference,
        foodItemPrice,
      ];
}
