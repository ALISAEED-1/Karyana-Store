



import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/users.dart';


class UserServices{

  // create
  Future createUser(UsersModel model)async
  {
    return await FirebaseFirestore.instance
        .collection("Usercollection")
        .doc(model.docId)
        .set(model.toJson(model.docId.toString()));
  }

  // update
  Future updateUser(UsersModel model)async
  {
    return await FirebaseFirestore.instance
        .collection("Usercollection")
        .doc(model.docId)
        .update({
      "name" : model.name,
      "phone": model.phone,
      "address": model.address,
        });
  }

  // delete
  Future deleteUser(UsersModel model)async
  {
    return await FirebaseFirestore.instance
        .collection("Usercollection")
        .doc(model.docId)
        .delete();
  }

//   getby id
  Future<UsersModel> getuserbyID(String userID)async{
    return await FirebaseFirestore.instance
        .collection("Usercollection")
        .doc(userID)
        .get()
        .then((val){
      return UsersModel.fromJson(val.data()!);
    });
  }
}