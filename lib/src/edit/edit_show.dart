import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_next/src/controllers/movie_search_controller.dart';
import 'package:what_next/src/edit/text_edit.dart';

class EditShowForm extends StatefulWidget {
  const EditShowForm({super.key});

  @override
  State<EditShowForm> createState() => _EditShowFormState();
}

class _EditShowFormState extends State<EditShowForm> {
  final _formKey = GlobalKey<FormState>();
  String searchText = '';
  final searcher = Get.put(MovieSearchController());

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    return Material(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            constraints: const BoxConstraints(minWidth: 100, maxWidth: 400),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextEdit(
                    label: 'Name of series or movie',
                    textRequired: true,
                    onChanged: (text) {
                      searchText = text;
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar.
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                            // TODO: find
                            await searcher.search(text: searchText);
                            print(searcher.searchResults);
                          }
                        },
                        child: const Text('Save'),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),
                  Expanded(
                    child: GetBuilder<MovieSearchController>(
                      builder: (controller) {
                        return ListView.builder(
                          itemCount: controller.searchResults.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title:
                                  Text(controller.searchResults[index].title),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
