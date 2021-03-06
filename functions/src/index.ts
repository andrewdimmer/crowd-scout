import * as functions from "firebase-functions";
import { getNearbyPlacesFromLatLong } from "./getNearbyPlacesFromLatLong";
import { getPlacesFromSearch } from "./getPlacesFromSearch";
import { updateCapacity } from "./updateCapacity";
import { updateCrowd } from "./updateCrowd";

// Start writing Firebase Functions
// https://firebase.google.com/docs/functions/typescript

export const helloWorld = functions.https.onRequest((request, response) => {
  response.send("Hello from Firebase!");
});

export const get_places_from_search = getPlacesFromSearch;
export const get_nearby_places_from_lat_long = getNearbyPlacesFromLatLong;
export const update_capacity = updateCapacity;
export const update_crowd = updateCrowd;
