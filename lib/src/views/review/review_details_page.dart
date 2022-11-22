import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_next/src/controllers/auth_controller.dart';
import 'package:what_next/src/controllers/my_reviews_controller.dart';
import 'package:what_next/src/controllers/reviews_controller.dart';
import 'package:what_next/src/utils/layout.dart';
import 'package:what_next/src/views/edit/edit_review.dart';
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
  final authCtl = Get.find<AuthCtl>();

  @override
  Widget build(BuildContext context) {
    review = getReview(widget.reviewId);
    return Scaffold(
      appBar: AppBar(
        title: Text(review.title),
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
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          editMyReview();
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.edit),
      ),
    );
  }

  getCard(Review review, List<Review> reviewsForShow) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.network(
              review.fullImageUrlLarge,
              // height: 200,
            ),
            addVerticalSpace(10),
            ListView.builder(
                shrinkWrap: true,
                itemCount: reviewsForShow.length,
                itemBuilder: (context, index) {
                  return Column(
                    key: Key('$index'),
                    children: [
                      ListTile(
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: StarRating(
                            rating: reviewsForShow[index].rating,
                          ),
                        ),
                        subtitle: Text(reviewsForShow[index].comment),
                        tileColor: Colors.black12,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
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

  void editMyReview() {
    late Review myReview;
    var myReviews = myReviewsController.reviewList
        .where((r) => r.id == widget.reviewId)
        .where((r) => r.user == authCtl.user!.uid)
        .toList();
    if (myReviews.isEmpty) {
      // clone from existing review
      myReview = Review.clone(review);
      myReview.comment = '';
      myReview.rating = 0;
      myReview.user = authCtl.user!.uid;
      myReview.when = Timestamp.now();
    } else {
      myReview = myReviews.first;
    }
    Get.to(EditReview(review: myReview));
  }
}
