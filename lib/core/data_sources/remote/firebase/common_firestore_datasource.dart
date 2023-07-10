import 'package:cloud_firestore/cloud_firestore.dart';

class CommonFirestoreDatasource {

  Stream<List<T>> collectionStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data,DocumentReference reference) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    Query query = FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result =
      snapshot.docs
          .map((snapshot) => builder(snapshot.data() as Map<String, dynamic>,snapshot.reference))
          .where((value) => value != null)
          .toList();

      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

  Future<void> updateData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    print('$path: $data');
    await reference.update(data);
  }

  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    print('$path: $data');
    await reference.set(data);
  }

  Future<void> deleteData({required String path}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    print('delete: $path');
    await reference.delete();
  }

  Stream<T> oneStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data,DocumentReference reference) builder,
    Query Function(Query query)? queryBuilder,
  }) {
    Query query = FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result =
          snapshot.docs
              .map((snapshot) => builder(snapshot.data() as Map<String, dynamic>,snapshot.reference))
              .where((value) => value != null)
              .toList().first;

      return result;
    });
  }



}

