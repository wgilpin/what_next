import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_next/src/controllers/my_reviews_controller.dart';
import 'package:what_next/src/controllers/recommends_controller.dart';
import 'package:what_next/src/models/review.dart';
import 'package:what_next/src/views/drawer.dart';
import 'package:what_next/src/views/edit/find_show.dart';
import 'package:what_next/src/views/recommend/film_strip.dart';

class RecommendsPage extends StatelessWidget {
  final MyReviewsCtl myReviewsController = Get.put(MyReviewsCtl());
  final RecommendsCtl recommendsController = Get.put(RecommendsCtl());

  RecommendsPage({super.key});

  final RxList<List<Review>> data = RxList<List<Review>>([]);
  final RxList<String> labels = RxList<String>([]);

  @override
  Widget build(BuildContext context) {
    labels.add('My Reviews');
    data.add(myReviewsController.reviews);
    labels.add("Other People's");
    data.add(recommendsController.reviews);
    data.refresh();
    return Scaffold(
      appBar: AppBar(
        title: const Text('What Next'),
      ),
      body: SafeArea(
        child: Obx(() {
          labels.clear();
          data.clear();
          labels.add('My Reviews');
          data.add(myReviewsController.reviews);
          labels.add("Other People's");
          data.add(recommendsController.reviews);
          print('data: ${data.length}');
          return data.isEmpty
              ? const CircularProgressIndicator()
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            labels[index],
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (data[index].isEmpty)
                            const Text('      No shows here'),
                          if (data[index].isNotEmpty)
                            FilmStrip(data: data[index]),
                        ],
                      ),
                    );
                  });
        }),
      ),
      drawer: getDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const FindShowForm());
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
