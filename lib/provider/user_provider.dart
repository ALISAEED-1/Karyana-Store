

import 'package:backend_project/models/users.dart';
import 'package:flutter/cupertino.dart';


class UserProvider extends ChangeNotifier{

  UsersModel _userModel = UsersModel();

  void setuser(UsersModel model)
  {
    _userModel = model;
    notifyListeners();
  }

  UsersModel getuser()=>_userModel;

}