import GoogleMaps

func testReverseGeocodingIssue() {
    GMSServices.provideAPIKey(
        "Update your API key here, with one matching the app's bundle identifier"
    )

    let coordinate = CLLocationCoordinate2D(
        latitude: 48.813472,
        longitude: 2.3723817
    )

    GMSGeocoder().reverseGeocodeCoordinate(coordinate) { response, error in
        if let error = error {
            print("Couldn't reverse geocode \(coordinate): \(error)")
            return
        }

        guard let firstResult = response?.firstResult(), let allResults = response?.results() else {
            print("Couldn't get a result from reverse geocoding \(coordinate)")
            return
        }

        print(
"""
Reverse geocoding: \(coordinate)

response.firstResult(): \(firstResult)

response.allResults(): \(allResults)

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
"""
        )
    }

}
