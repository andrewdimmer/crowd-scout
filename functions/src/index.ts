import * as functions from "firebase-functions";
import { getNearbyPlacesFromLatLong } from "./getNearbyPlacesFromLatLong";
import { getPlacesFromSearch } from "./getPlacesFromSearch";

// Start writing Firebase Functions
// https://firebase.google.com/docs/functions/typescript

export const helloWorld = functions.https.onRequest((request, response) => {
  response.send("Hello from Firebase!");
});

export const get_places_from_search = getPlacesFromSearch;
export const get_nearby_places_from_lat_long = getNearbyPlacesFromLatLong;
