import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_ai/core/services/database_service.dart';

class FirestoreService implements DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  }) async {
    if (documentId != null) {
      firestore.collection(path).doc(documentId).set(data);
    } else {
      firestore.collection(path).add(data);
    }
  }

  @override
  Future<dynamic> getData({
    required String path,
    String? documentId,
    Map<String, dynamic>? query,
  }) async {
    if (documentId != null) {
      var data = await firestore.collection(path).doc(documentId).get();
      var res = data.data();
      if (res != null) {
        res['id'] = data.id;
      }
      return res;
    } else {
      Query<Map<String, dynamic>> data = firestore.collection(path);
      if (query != null) {
        if (query['orderBy'] != null) {
          var orderByField = query['orderBy'];
          var descending = query['descending'];
          data = data.orderBy(orderByField, descending: descending);
        }
        if (query['limit'] != null) {
          var limit = query['limit'];
          data = data.limit(limit);
        }
      }
      var result = await data.get();

      return result.docs.map((e) {
        var mapData = e.data();
        mapData['id'] = e.id; 
        return mapData;
      }).toList();
    }
  }

  @override
  Future<bool> isDataExists({
    required String path,
    required String documentId,
  }) {
    return firestore.collection(path).doc(documentId).get().then((doc) {
      return doc.exists;
    });
  }
}
