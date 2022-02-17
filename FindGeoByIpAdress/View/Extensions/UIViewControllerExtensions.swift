import MapKit

extension UIViewController {
    ///Opens a given location in a system-default map application and makes a route to it
    func openMap(destinationName: String, latitude: Double, longitude: Double) {
        let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude)))
        destination.name = destinationName

        MKMapItem.openMaps(
            with: [destination],
            launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        )
    }
}
