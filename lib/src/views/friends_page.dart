import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_next/src/controllers/users_controller.dart';
import 'package:what_next/src/models/user_profile.dart';
import 'package:what_next/src/theme.dart';
import 'package:what_next/src/utils/layout.dart';
import 'package:what_next/src/views/drawer.dart';

class FriendsPage extends StatelessWidget {
  final UserProfilesCtl friendsCtl = Get.put(UserProfilesCtl());

  FriendsPage({super.key});
  final searchName = ''.obs;
  final RxList<UserProfile> searchResults = RxList<UserProfile>([]);
  final RxList<UserProfile> friendsList = RxList<UserProfile>([]);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: makeTheme(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('What Next'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  onChanged: ((text) => searchName.value = text),
                  onSubmitted: (_) => {doSearch()},
                  autofocus: true,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.search),
                    hintText: "Your friend's name",
                    labelText: 'Find a friend',
                  ),
                ),
                Obx(() {
                  friendsList.clear();
                  friendsList.addAll(friendsCtl.friends);
                  debugPrint(
                      'in friends page. Friends count: ${friendsList.length}');
                  return SizedBox(
                    height: 300,
                    child: Column(
                      children: [
                        if (searchName.value.length >= 3)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton.icon(
                              onPressed: doSearch,
                              icon: const Icon(Icons.search),
                              label: const Text('Search'),
                            ),
                          )
                        else
                          const Text(''),
                        if (searchResults.isNotEmpty)
                          Expanded(
                            child: ListView.builder(
                                itemCount: searchResults.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                      leading: const Icon(Icons.person),
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(toTitleCase(searchResults[index]
                                              .displayName)),
                                          TextButton(
                                              child: const Text('add friend'),
                                              onPressed: () => addFriend(
                                                  searchResults[index]))
                                        ],
                                      ));
                                }),
                          )
                        else
                          const Text(''),
                        addVerticalSpace(20),
                        Text('Friends',
                            style: Theme.of(context).textTheme.headline6),
                        if (friendsCtl.friends.isEmpty)
                          const Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Text(
                                'You have no friends yet. Type an email address to invite them'),
                          )
                        else
                          ListView.builder(
                            itemCount: friendsCtl.friends.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: const Icon(Icons.person),
                                title:
                                    Text(friendsCtl.friends[index].displayName),
                              );
                            },
                          )
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
        drawer: getDrawer(),
      ),
    );
  }

  void doSearch() {
    searchResults.clear();
    UserProfilesCtl().findUser(searchName.value).then((value) {
      searchResults.addAll(value);
    });
  }

  String toTitleCase(String str) {
    return str
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  addFriend(UserProfile friend) async {
    await UserProfilesCtl().addFriend(friend);
  }
}
