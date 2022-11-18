import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

// // Start writing functions
// // https://firebase.google.com/docs/functions/typescript
//
export const helloWorld = functions
    .region("europe-west1")
    .https.onRequest((request, response) => {
      functions.logger.info("Hello logs!", {structuredData: true});
      response.send("Hello from Firebase!");
    });

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
