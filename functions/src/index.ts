import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {firestore} from "firebase-admin";

admin.initializeApp();

// https://firebase.google.com/docs/functions/typescript

export const newUser = functions
    .region("europe-west1")
    .auth.user()
    .onCreate((user) => {
      admin.database().ref("users").child(user.uid).set({
        display_name: user.displayName?.toLowerCase(),
      });
      functions.logger.info("New user created", {structuredData: true});
      functions.logger.info(user); // log the user object
      return null;
    });

export const removeUser = functions
    .region("europe-west1")
    .auth.user()
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
