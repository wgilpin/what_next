import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:what_next/src/models/review.dart';

class FirestoreDB {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Review>> getMyMovies() {
    return _firestore
        .collection('reviews')
        .where('user', isEqualTo: FirebaseAuth.instance.currentUser)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Review.fromSnapshot(doc))
            .toList());
  }
}
