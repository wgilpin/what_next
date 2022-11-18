import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
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
        body: SafeArea(
          child: Obx(() {
            friendsList.clear();
            friendsList.addAll(friendsCtl.friends);
            debugPrint('in friends page. Friends count: ${friendsList.length}');
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      addVerticalSpace(50),
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
                              title: Text(toTitleCase(
                                  friendsCtl.friends[index].displayName)),
                            );
                          },
                        )
                    ],
                  ),
                ),
                buildFloatingSearchBar(context),
              ],
            );
          }),
        ),
        drawer: getDrawer(),
      ),
    );
  }

  Widget buildFloatingSearchBar(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Search for friends',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        doSearch(query);
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            elevation: 4.0,
            child: Obx(() => Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            leading: const Icon(Icons.person),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(toTitleCase(
                                    searchResults[index].displayName)),
                                TextButton(
                                    child: const Text('add friend'),
                                    onPressed: () =>
                                        addFriend(searchResults[index]))
                              ],
                            ));
                      }),
                )),
          ),
        );
      },
    );
  }

  void doSearch(String name) {
    searchResults.clear();
    UserProfilesCtl().findUser(name).then((profilesFound) {
      // add to searchResults if not already in friendsList
      for (var profileFound in profilesFound) {
        if (!friendsList
            .any((currentFriend) => currentFriend.id == profileFound.id)) {
          searchResults.add(profileFound);
        }
      }
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
