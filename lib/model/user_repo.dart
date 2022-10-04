import 'package:ecommerce/class/user.dart';
import 'package:ecommerce/model/order_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserRepo extends StateNotifier<User> {
  static UserRepo? userRepoInstance;
  static User user = User();
  UserRepo._() : super(user);

  static UserRepo getInstance() {
    return userRepoInstance ??= UserRepo._();
  }

  void setUser(int id) {
    state.id = id;
  }
}
