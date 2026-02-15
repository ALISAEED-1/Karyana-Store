import 'package:backend_project/models/product.dart';
import 'package:backend_project/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ProductServices{

  //1. create task
  Future createProduct(ProductModel model)async{
    DocumentReference docRef  = FirebaseFirestore.instance
        .collection("productcollection")
        .doc();
    return await FirebaseFirestore.instance
        .collection("productcollection")
        .doc(docRef.id)
        .set(model.toJson(docRef.id));

  }

  //2. update task
  Future updateProduct(ProductModel model)async{
    return await FirebaseFirestore.instance
        .collection("productcollection")
        .doc(model.docId)
        .update({
      "name" : model.name,
      "image": model.image,
      "prize": model.prize,
      "discountprize": model.discountprize,
      "stock": model.stock,
      "categoryId": model.categoryId,
      "createdAt": model.createdAt,
        });

  }

  //3. delete task
  Future deleteProduct(String docId)async{
    return await FirebaseFirestore.instance
        .collection("productcollection")
        .doc(docId)
        .delete();
  }


  //4. get all task
  Stream<List<ProductModel>> getAllProduct() {
    return FirebaseFirestore.instance
        .collection("productcollection")
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => ProductModel.fromJson(doc.data()))
        .toList());
  }

  Stream<List<ProductModel>> getFavorite(String userId) {
    return FirebaseFirestore.instance
        .collection("productcollection")
        .where("favorite", arrayContains: userId) // 🔥 Only favorites
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => ProductModel.fromJson(doc.data())).toList());
  }


// add to favorite
  Future addtofavorite({
    required String userId,
    required String ProductId,
  }) async {
    return await FirebaseFirestore.instance
        .collection("productcollection")
        .doc(ProductId)
        .update({'favorite': FieldValue.arrayUnion([userId])});
  }

  Future removefromfavorite({
    required String userId,
    required String ProductId,
  }) async {
    return await FirebaseFirestore.instance
        .collection("productcollection")
        .doc(ProductId)
        .update({'favorite': FieldValue.arrayRemove([userId])});
  }


  //   get Product by Category Id
  Stream<List<ProductModel>> getProductsByCategoryId(String categoryId) {
    return FirebaseFirestore.instance
        .collection("productcollection")
        .where("categoryId", isEqualTo: categoryId)
        .snapshots()
        .map((snap) =>
        snap.docs.map((doc) => ProductModel.fromJson(doc.data())).toList());
  }

}