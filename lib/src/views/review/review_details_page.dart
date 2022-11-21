import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_next/src/controllers/my_reviews_controller.dart';
import 'package:what_next/src/controllers/reviews_controller.dart';
import 'package:what_next/src/utils/layout.dart';
import 'package:what_next/src/views/edit/star_rating.dart';

import '../../models/review.dart';

class ReviewDetailsPage extends StatefulWidget {
  final String reviewId;
  const ReviewDetailsPage({super.key, required this.reviewId});

  @override
  State<ReviewDetailsPage> createState() => _ReviewDetailsPageState();
}

class _ReviewDetailsPageState extends State<ReviewDetailsPage> {
  late List<Review> reviewsForShow;
  late Review review;
  final reviewsController = Get.find<ReviewsCtl>();
  final myReviewsController = Get.find<MyReviewsCtl>();

  @override
  Widget build(BuildContext context) {
    review = getReview(widget.reviewId);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Review Details'),
        ),
        body: FutureBuilder<List<Review>>(
            future: reviewsController.getReviewsForShow(widget.reviewId),
            builder: (
              BuildContext context,
              AsyncSnapshot<List<Review>> snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                debugPrint('cnx waiting');
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    Visibility(
                      visible: snapshot.hasData,
                      child: const Text(
                        'Loading',
                        style: TextStyle(color: Colors.black, fontSize: 24),
                      ),
                    )
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                debugPrint('cnx done');
                if (snapshot.hasError) {
                  debugPrint('cnx error');
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  debugPrint('cnx hasdata');
                  return getCard(review, snapshot.data!);
                } else {
                  debugPrint('cnx empty');

                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            }));
  }

  getCard(Review review, List<Review> reviewsForShow) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.network(
              review.fullImageUrlLarge,
              // height: 200,
            ),
            addVerticalSpace(10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                review.title,
                style: Theme.of(context).textTheme.headline5,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            addVerticalSpace(10),
            ListView.builder(
                shrinkWrap: true,
                itemCount: reviewsForShow.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: StarRating(
                      rating: reviewsForShow[index].rating,
                    ),
                    subtitle: Text(reviewsForShow[index].comment),
                    tileColor: Colors.black12,
                  );
                }),
          ],
        ),
      ),
      // list all reviews
    );
  }

  Review getReview(String id) {
    var mine = myReviewsController.reviewList.where((r) => r.id == id);
    if (mine.isNotEmpty) {
      return mine.first;
    }
    var others = reviewsController.reviewList.where((r) => r.id == id);
    return others.first;
  }
}
