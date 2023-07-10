import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smartdine_waiter/features/restaurant_home/data/models/restaurant_model.dart';

import '../components/homepage_colors.dart';

Widget buildRestaurantCard(RestaurantModel restaurant,
    List<String> localFoodPics, int index, BuildContext context) {
  Random random = Random();
  return GestureDetector(
    onTap: () {
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => BlocProvider<RestaurantMenuCubit>(
      //               create: (BuildContext context) =>
      //                   di.sl<RestaurantMenuCubit>()
      //                     ..getRestaurantById(
      //                         restaurant.documentReference!.id.toString()),
      //               child: BlocProvider<CartCubit>(
      //                 create: (context) => di.sl<CartCubit>()..fetchCart(),
      //                 child: RestaurantMenu(),
      //               ),
      //             )));
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            constraints: const BoxConstraints.expand(height: 200.0, width: 450),
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.only(left: 16.0, bottom: 8.0, top: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: restaurant.restaurantImages!.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(restaurant.restaurantImages![0]),
                      fit: BoxFit.fill,
                    )
                  : DecorationImage(
                      image:
                          AssetImage(localFoodPics[0 + random.nextInt(10 - 0)]),
                      fit: BoxFit.fill,
                    ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          left: 5, right: 10, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                          color: AppColors.persianColor,
                          borderRadius: BorderRadius.circular(5.0)),
                      child: const Text('Well senitized kitchens',
                          style: TextStyle(
                              fontSize: 12.0, color: AppColors.whiteColor)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                restaurant.restaurantName.toString(),
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackColor,
                    fontSize: 24.0),
              ),
            ],
          ),
        ),
        const Divider(color: Color(0xFFF2F2F2)),
        const SizedBox(
          height: 1,
        )
      ],
    ),
  );
}
