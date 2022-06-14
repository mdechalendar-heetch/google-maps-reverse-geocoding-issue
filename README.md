# google-maps-reverse-geocoding-issue
A demo repository to reproduce an issue with Google Maps' reverse geocoding feature

# References
- [Internal Heetch issue](https://retool.atlassian.net/browse/PGT-2259)
- [Google issue](https://issuetracker.google.com/issues/235850430)

# How to test it
1. Clone the project
2. Open `GoogleMapsWrongReverseGeocoding.xcworkspace` (`Pods` folder is in the repository)
3. Replace `GoogleMapsReverseGeocodingIssue.swift#5` with a valid API key, updating the bundle ID if needed
4. Build & run (any simulator or device)
5. Read the message in the console, which explains the issue in more details.  
_If, for some reason, there was an issue and the project wouldn't run, I've also copy/pasted the message from the console below ⬇️_

```
Reverse geocoding: CLLocationCoordinate2D(latitude: 48.813472, longitude: 2.3723817)

response.firstResult(): GMSAddress {
coordinate: (48.813472, 2.372382)
lines: 25 Rue Pierre et Marie Curie, 60510 Bresles, France
thoroughfare: 25 Rue Pierre et Marie Curie
locality: Bresles
administrativeArea: Île-de-France
postalCode: 60510
country: France
}


response.allResults(): [GMSAddress {
coordinate: (48.813472, 2.372382)
lines: 25 Rue Pierre et Marie Curie, 60510 Bresles, France
thoroughfare: 25 Rue Pierre et Marie Curie
locality: Bresles
administrativeArea: Île-de-France
postalCode: 60510
country: France
}
, GMSAddress {
coordinate: (48.813472, 2.372382)
lines: 25 Rue Pierre et Marie Curie, 94200 Ivry-sur-Seine, France
thoroughfare: 25 Rue Pierre et Marie Curie
locality: Ivry-sur-Seine
administrativeArea: Île-de-France
postalCode: 94200
country: France
}
, GMSAddress {
coordinate: (48.813472, 2.372382)
lines: 30-44 Rue Pierre et Marie Curie, 94200 Ivry-sur-Seine, France
thoroughfare: 30-44 Rue Pierre et Marie Curie
locality: Ivry-sur-Seine
administrativeArea: Île-de-France
postalCode: 94200
country: France
}
, GMSAddress {
coordinate: (48.813472, 2.372382)
lines: 94200 Ivry-sur-Seine, France
locality: Ivry-sur-Seine
administrativeArea: Île-de-France
postalCode: 94200
country: France
}
, GMSAddress {
coordinate: (48.813472, 2.372382)
lines: 94200 Ivry-sur-Seine, France
locality: Ivry-sur-Seine
administrativeArea: Île-de-France
postalCode: 94200
country: France
}
, GMSAddress {
coordinate: (48.813472, 2.372382)
lines: Canton d'Ivry-sur-Seine, 94200 Ivry-sur-Seine, France
subLocality: Canton d'Ivry-sur-Seine
locality: Ivry-sur-Seine
administrativeArea: Île-de-France
postalCode: 94200
country: France
}
, GMSAddress {
coordinate: (48.813472, 2.372382)
lines: Arrondissement de l'Haÿ-les-Roses, France
locality: Arrondissement de l'Haÿ-les-Roses
administrativeArea: Île-de-France
country: France
}
]

Comments:
    firstResult.coordinate == (48.813472, 2.372382)
    firstResult.thoroughfare == 25 Rue Pierre et Marie Curie
    firstResult.locality == Bresles
    firstResult.postalCode == 60510

    An adress with this `thoroughfare`, `locality` and `postalCode` exists, but it it not located at this `coordinate`:
    https://www.google.com/maps/place/25+Rue+Pierre+et+Marie+Curie,+60510+Bresles/@49.4090692,2.2537256,17z/data=!3m1!4b1!4m5!3m4!1s0x47e7ac3e7c237f87:0xa370c2437a99b84f!8m2!3d49.4090657!4d2.2559143

    At this coordinate, `locality` should be `Ivry-Sur-Seine` and `postalCode` should be `94200`.
    The other results from the `response.results()` array all have the correct `locality` and `postalCode`

    If you search for "(`coordinate.latitude`, `coordinate.longitude`)" using google.com/maps, it is correctly reverse geocoded:
    https://www.google.com/maps/place/48°48'48.5%22N+2°22'20.6%22E/@48.8134755,2.370193,17z/data=!3m1!4b1!4m5!3m4!1s0x0:0xca01302227831efc!8m2!3d48.813472!4d2.3723817

    Calling the /geocode endpoint from maps.googleapis.com directly has the correct first result as well.
    You'll notice that the wrong result is indeed in the list, but in the second place:
    https://maps.googleapis.com/maps/api/geocode/json?key=SOME_VALID_API_KEY&latlng=48.813472,%202.3723817
```
