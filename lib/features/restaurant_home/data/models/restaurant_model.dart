import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class RestaurantModel extends Equatable {
  final DocumentReference? documentReference;
  final String? maxBookCapacity;
  final List<String>? restaurantImages;
  final GeoPoint? location;
  final String? restaurantName;
  final String? restaurantLogo;
  final String? restaurantAddress;
  final String? totalChefs;
  final String? totalTables;
  final String? totalWaiters;

  RestaurantModel(
      {this.maxBookCapacity,
      this.restaurantImages,
      this.location,
      this.restaurantName,
      this.restaurantLogo,
      this.restaurantAddress,
      this.totalChefs,
      this.totalTables,
      this.totalWaiters,
      this.documentReference});

  factory RestaurantModel.fromMap(
      Map<String, dynamic> json, DocumentReference documentReference) {
    List<String> imageList = [];
    if (json["restaurant_images"] != null) {
      json["restaurant_images"].forEach((item) {
        return imageList.add(item);
      });
    }

    return RestaurantModel(
      documentReference: documentReference,
      maxBookCapacity: json["max_booking_capacity"] ?? "",
      location: json["location"] ?? const GeoPoint(0, 0),
      restaurantImages: imageList,
      restaurantName: json["restaurant_name"] ?? "",
      restaurantLogo: json["restaurant_logo"] ?? "",
      restaurantAddress: json["restaurant_address"] ?? "",
      totalChefs: json["total_chefs"] ?? "0",
      totalTables: json["total_tables"] ?? "0",
      totalWaiters: json["total_waiters"] ?? "0",
    );
  }
  Map<String, dynamic> toMap() {
    var imageList = restaurantImages as List<String>;

    return {
      "documentReference": documentReference,
      "max_booking_capacity": maxBookCapacity,
      "location": location,
      "restaurant_name": restaurantName,
      "restaurant_images": List<String>.from(imageList),
      "restaurant_logo": restaurantLogo,
      "restaurant_address": restaurantAddress,
      "total_chefs": totalChefs,
      "total_tables": totalTables,
      "total_waiters": totalWaiters,
    };
  }

  @override
  List<Object?> get props => [
        maxBookCapacity,
        restaurantImages,
        location,
        restaurantName,
        restaurantLogo,
        restaurantAddress,
        totalChefs,
        totalTables,
        totalWaiters,
        documentReference
      ];
}
