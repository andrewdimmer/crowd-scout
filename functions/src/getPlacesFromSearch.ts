import * as functions from "firebase-functions";
import { get } from "request-promise-native";
// import * as ky from "ky"; //TODO: Figure out wky ky is not working for the future.

// Start writing Firebase Functions
// https://firebase.google.com/docs/functions/typescript

export const getPlacesFromSearch = functions.https.onRequest(
  (request, response) => {
    const requestBody = request.body as string;
    const splitBody = requestBody.split(";", 3);
    const fields =
      "business_status,formatted_address,geometry,icon,name,photos,place_id,types";
    const url: string = `https://maps.googleapis.com/maps/api/place/findplacefromtext/json?key=${
      functions.config().google_maps_places_api.api_key
    }&input=${splitBody[2].replace(
      / /g,
      "%20"
    )}&inputtype=textquery&fields=${fields}&locationbias=point:${
      splitBody[0]
    },${splitBody[1]}`;
    get(url)
      .then((value) => response.send(value))
      .catch((err: any) => {
        console.log(err);
        response.send(null);
      });
  }
);
