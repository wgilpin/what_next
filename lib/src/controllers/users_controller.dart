import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:what_next/src/controllers/auth_controller.dart';
import 'package:what_next/src/models/user_profile.dart';

class UserProfilesCtl extends GetxController {
  final RxList<UserProfile> _friendList = RxList<UserProfile>([]);

  List<UserProfile> get friends => _friendList;

  @override
  void onReady() {
    super.onReady();
    var uid = Get.find<AuthCtl>().user!.uid;
    _friendList.bindStream(friendsForUserStream(uid));
    debugPrint('MyfriendsCtl bound to stream');
  }

  Stream<List<UserProfile>> friendsForUserStream(String uid) {
    debugPrint('in friendsForUserStream');
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('friends')
        .snapshots()
        .map((QuerySnapshot query) {
      List<UserProfile> friends = [];
      for (var friend in query.docs) {
        final userProfile = UserProfile.fromSnapshot(friend);
        friends.add(userProfile);
      }

      debugPrint('friendsForUser Stream: ${friends.length}');
      return friends;
    });
  }

  Future<List<UserProfile>> findUser(String name) async {
    debugPrint('in findUser');
    List<UserProfile> friends = [];
    await FirebaseFirestore.instance
        .collection('users')
        .where('display_name', isGreaterThanOrEqualTo: name)
        .where('display_name', isLessThan: '$name\uf8ff')
        .get()
        .then((QuerySnapshot query) {
      for (var f in query.docs) {
        final friendModel = UserProfile.fromSnapshot(f);
        friends.add(friendModel);
      }
    });
    debugPrint('findUser:${friends.length}');
    return friends;
  }

  Future<void> addFriend(UserProfile friend) async {
    var authController = Get.find<AuthCtl>();
    if (authController.user == null) {
      return;
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(authController.user!.uid)
        .collection('friends')
        .doc(friend.id)
        .set({'display_name': friend.displayName});
  }
}
