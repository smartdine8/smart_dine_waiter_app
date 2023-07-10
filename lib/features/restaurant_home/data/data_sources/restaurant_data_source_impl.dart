import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:smartdine_waiter/features/restaurant_home/data/data_sources/restaurant_data_source.dart';
import 'package:smartdine_waiter/features/restaurant_home/data/models/restaurant_menu_item_model.dart';
import 'package:smartdine_waiter/features/restaurant_home/data/models/restaurant_model.dart';

class RestaurantDataSourceImpl extends RestaurantDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore fireStore;
  final FirebaseStorage firebaseStorage;
  late String verId;

  RestaurantDataSourceImpl(
      {required this.auth,
      required this.fireStore,
      required this.firebaseStorage});

  @override
  Future<RestaurantModel> getRestaurant() async {
    final restaurantData = await fireStore
        .collection('restaurant')
        .doc('70AOu1dA65t7FaZh8MSR')
        .get()
        .then((snapshot) {
      RestaurantModel restaurent =
          RestaurantModel.fromMap(snapshot.data()!, snapshot.reference);
      return restaurent;
    });

    return restaurantData;
  }

  @override
  Stream<List<RestaurantMenuItemModel>> getRestaurantMenu() {
    final restaurantData = fireStore
        .collection('menu')
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.map((doc) {
              return RestaurantMenuItemModel.fromMap(doc.data(), doc.reference);
            }).toList())
        .handleError((error, stackTrace) {
      print('Error getting menu documents: $error');
      // Handle the error accordingly
    });

    print("restaurantData::$restaurantData");
    return restaurantData;
  }
}
