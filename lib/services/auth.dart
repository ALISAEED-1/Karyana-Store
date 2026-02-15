
import 'package:firebase_auth/firebase_auth.dart';

class authservices{

  Future<User> registeruser({required String email , required String password})
  async
  {
    try{
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      userCredential.user!.sendEmailVerification();
      return userCredential.user!;


    }
    catch(e){
      throw e.toString();
    }
  }

  Future<User> loginuser({required String email , required String password})async
  {
    try{
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user!;
    }
    catch(e){
      throw e.toString();
    }
  }

  Future resetpassword(String email)async
  {
    try{
      return await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email);
    }
    catch(e){
      throw e.toString();
    }
  }
}