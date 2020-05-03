import * as functions from "firebase-functions";
import { get } from "request-promise-native";
// import * as ky from "ky";

// Start writing Firebase Functions
// https://firebase.google.com/docs/functions/typescript

export const getNearbyPlacesFromLatLong = functions.https.onRequest(
  (request, response) => {
    const requestBody = request.body as string;
    const splitBody = requestBody.split(";", 3);
    const url: string = `https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=${
      functions.config().google_maps_places_api.api_key
    }&location=${splitBody[0]},${splitBody[1]}&radius=${splitBody[2]}`;
    console.log(url);
    get(url)
      .then((value) => response.send(value))
      .catch((err: any) => {
        console.log(err);
        response.send(null);
      });
  }
);
