import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {firestore} from "firebase-admin";

let config = {};

if (process.env.ENVIRONMENT === "local") {
  const projectId = "what-next-317512";
  config = {
    projectId: projectId,
    databaseURL: `http://localhost:8080/?ns=${projectId}`,
  };
}
admin.initializeApp(config);

// admin.auth;
// import firebase from "firebase/app";

// admin.functions().useEmulator("localhost", 5001);
// const db = firebase.firestore();
// if (location.hostname === "localhost") {
//   db.useEmulator("localhost", 8080);
// }

// https://firebase.google.com/docs/functions/typescript

// TODO: use displayName from the user object not this profile in the DB

// export const newUser = functions.auth // .region("europe-west1")
//     .user()
//     .onCreate((user) => {
//       admin.database().ref("users").child(user.uid).set({
//         display_name: user.displayName?.toLowerCase(),
//       });
//       functions.logger.info("New user created", {structuredData: true});
//       functions.logger.info(user); // log the user object
//       return null;
//     });

export const removeUser = functions.auth // .region("europe-west1")
    .user()
    .onDelete(async (user) => {
      firestore().collection("users").doc(user.uid).delete();
      const docs = await firestore()
          .collectionGroup("reviews")
          .where("user", "==", user.uid)
          .get();
      docs.forEach((element) => {
        element.ref.delete();
      });
      functions.logger.info("User deleted", {structuredData: true});
      functions.logger.info(user); // log the user object
      return null;
    });

//
// Set the ACL for a review
//  - the list of users that can see it
//
const updateReviewAcl = async (authorId: string, showId: string) => {
  functions.logger.info(`updateReviewAcl ${authorId} ${showId}`);
  // get author's friends
  const querySnapshot = await firestore()
      .collection("users")
      .doc(authorId)
      .collection("friends")
      .get();
  const friends: string[] = [];
  querySnapshot.forEach((doc) => {
    friends.push(doc.id);
  });

  // also add author to the list
  friends.push(authorId);

  // add all friends to the ACL
  await firestore()
      .collection("movies")
      .doc(showId)
      .collection("reviews")
      .doc(authorId)
      .set({visible_to: friends}, {merge: true});
  functions.logger.info("Review ACL added", {
    structuredData: true,
  });
  functions.logger.info(authorId); // log the review object
  return null;
};

//
// When a review is created,
//    update its ACL
//
export const addReview = functions.firestore
    .document("movies/{showId}/reviews/{authorId}")
    .onCreate(async (snap, context) => {
      const review = snap.data();
      updateReviewAcl(review.user, context.params.showId);
    });

//
// update ACL for all of a user's reviews
//
const updateAllReviewsAcl = async (userId: string) => {
  const querySnapshot = await firestore()
      .collection("movies")
      .doc(userId)
      .collection("reviews")
      .get();
  querySnapshot.forEach(async (doc) => {
    await updateReviewAcl(userId, doc.data().movie_id);
  });
};

//
// When a friend is added or deleted,
//    update all reviews ACLs
//
export const updateFriends = functions.firestore
    .document("users/{userId}/friends/{friendId}")
    .onWrite(async (snap, context) => {
      await updateAllReviewsAcl(context.params.userId);
      functions.logger.info("Friend added so all reviews updated", {
        structuredData: true,
      });
      functions.logger.info(context.params.userId);
      return null;
    });
