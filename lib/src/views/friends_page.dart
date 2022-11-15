import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:what_next/src/models/user_profile.dart';
import 'package:what_next/src/theme.dart';
import 'package:what_next/src/utils/layout.dart';
import 'package:what_next/src/views/drawer.dart';

class FriendsPage extends StatelessWidget {
  FriendsPage({super.key});
  final emailAddress = ''.obs;
  final emailController = TextEditingController();
  RxList<UserProfile> friends = RxList<UserProfile>([]);

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
                TextFormField(
                  onChanged: (value) => emailAddress.value = value,
                  controller: emailController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.search),
                    hintText: "Your friend's email address",
                    labelText: 'Find a friend',
                  ),
                  validator: (String? value) {
                    return (value == null || GetUtils.isEmail(value))
                        ? 'Please enter a valid email address'
                        : null;
                  },
                ),
                Obx(() => GetUtils.isEmail(emailAddress.value)
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Invite'),
                        ),
                      )
                    : Text('')),
                addVerticalSpace(20),
                Text('Friends', style: Theme.of(context).textTheme.headline6),
                if (friends.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text(
                        'You have no friends yet. Type an email address to invite them'),
                  )
                else
                  Expanded(
                      child: ListView.builder(
                    itemCount: friends.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(friends[index].displayName),
                        subtitle: Text(friends[index].lastActive.toString()),
                      );
                    },
                  ))
              ],
            ),
          ),
        ),
        drawer: getDrawer(),
      ),
    );
  }
}
