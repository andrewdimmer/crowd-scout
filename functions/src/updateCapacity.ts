import * as functions from "firebase-functions";
import firebaseApp from "./firebaseConfig";

// Start writing Firebase Functions
// https://firebase.google.com/docs/functions/typescript

export const updateCapacity = functions.https.onRequest((request, response) => {
  const requestBody = request.body as string;
  const splitBody = requestBody.split(";", 2);
  const docRef = firebaseApp.firestore().collection("places").doc(splitBody[1]);
  firebaseApp
    .firestore()
    .runTransaction((t) => {
      return t.get(docRef).then((doc) => {
        if (doc.exists) {
          t.update(docRef, { capacity: splitBody[0] });
          return true;
        } else {
          t.set(docRef, { crowd: 0, capacity: splitBody[0] });
          return true;
        }
      });
    })
    .then(() => true)
    .catch((err) => {
      console.log(err);
      return false;
    });
  response.send(null);
});
