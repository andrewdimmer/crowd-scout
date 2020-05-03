import * as functions from "firebase-functions";
import { get } from "request-promise-native";
import firebaseApp from "./firebaseConfig";

// Start writing Firebase Functions
// https://firebase.google.com/docs/functions/typescript

export const updateCrowd = functions.https.onRequest((request, response) => {
  const requestBody = request.body as string;
  const splitBody = requestBody.split(";", 3);
  const url: string = `https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=${
    functions.config().google_maps_places_api.api_key
  }&location=${splitBody[0]},${splitBody[1]}&radius=${splitBody[2]}`;
  console.log(url);
  get(url)
    .then((value) => {
      console.log(typeof value);
      console.log(value);
      console.log(JSON.parse(value));
      const results = JSON.parse(value).results;
      if (results.length >= 2) {
        const docRef = firebaseApp
          .firestore()
          .collection("places")
          .doc(results[1].place_id);
        firebaseApp
          .firestore()
          .runTransaction((t) => {
            return t.get(docRef).then((doc) => {
              const docData = doc.data();
              if (doc.exists && docData) {
                t.update(docRef, { crowd: docData.crowd + 1 });
              } else {
                t.set(docRef, { crowd: 1, capacity: "?" });
              }
              return true;
            });
          })
          .then(() => true)
          .catch((err) => {
            console.log(err);
            return false;
          });
        response.send(null);
      } else {
        response.send(null);
      }
    })
    .catch((err: any) => {
      console.log(err);
      response.send(null);
    });
});
