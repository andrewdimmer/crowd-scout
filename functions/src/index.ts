import * as functions from "firebase-functions";
import { getPlacesFromSearch } from "./getPlacesFromSearch";

// Start writing Firebase Functions
// https://firebase.google.com/docs/functions/typescript

export const helloWorld = functions.https.onRequest((request, response) => {
  response.send("Hello from Firebase!");
});

export const get_places_from_search = getPlacesFromSearch;
