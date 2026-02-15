import 'package:backend_project/models/category.dart';
import 'package:backend_project/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class CategoryServices{

  //1. create task
  Future<void> createCategory(CategoryModel model)async {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection("categorycollection")
        .doc();

    // MUST return the Future directly (no inner 'await')
    return await FirebaseFirestore.instance
        .collection("categorycollection")
        .doc(docRef.id)
        .set(model.toJson(docRef.id));
  }

  //2. update task
  Future updateCategory(CategoryModel model)async{
    return await FirebaseFirestore.instance
        .collection("categorycollection")
        .doc(model.docId)
        .update({
      "categoryname" : model.categoryname,
      "image": model.image,
      "createdAt": model.createdAt,
        });

  }

  //3. delete task
  Future deleteCategory(String docId)async{
    return await FirebaseFirestore.instance
        .collection("categorycollection")
        .doc(docId)
        .delete();
  }


  //4. get all task
  Stream<List<CategoryModel>> getAllCategory() {
    return FirebaseFirestore.instance
        .collection("categorycollection")
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => CategoryModel.fromJson(doc.data()))
        .toList());
  }

  Future<List<CategoryModel>> getCategoryListOnce() async {
    return await getAllCategory().first;
  }


}