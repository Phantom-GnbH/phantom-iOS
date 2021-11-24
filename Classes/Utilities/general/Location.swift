//

import CoreLocation

//-----------------------------------------------------------------------------------------------------------------------------------------------
class Location: NSObject, CLLocationManagerDelegate {

	private var locationManager: CLLocationManager?
	private var location = CLLocation()

	//-------------------------------------------------------------------------------------------------------------------------------------------
	static let shared: Location = {
		let instance = Location()
		return instance
	} ()

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func setup() {

		_ = shared
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func start() {

		shared.locationManager?.startUpdatingLocation()
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func stop() {

		shared.locationManager?.stopUpdatingLocation()
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func latitude() -> CLLocationDegrees {

		return shared.location.coordinate.latitude
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func longitude() -> CLLocationDegrees {

		return shared.location.coordinate.longitude
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	class func address(completion: @escaping (String?, String?, String?) -> Void) {

		CLGeocoder().reverseGeocodeLocation(shared.location) { placemarks, error in
			if let placemark = placemarks?.first {
				completion(placemark.locality, placemark.country, placemark.isoCountryCode)
			} else {
				completion(nil, nil, nil)
			}
		}
	}

	//.devMARK: - Instance methods
	//-------------------------------------------------------------------------------------------------------------------------------------------
	override init() {

		super.init()

		locationManager = CLLocationManager()
		locationManager?.delegate = self
		locationManager?.desiredAccuracy = kCLLocationAccuracyBest
		locationManager?.requestWhenInUseAuthorization()
	}

	//.devMARK: - CLLocationManagerDelegate
	//-------------------------------------------------------------------------------------------------------------------------------------------
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

		if let location = locations.last {
			self.location = location
		}
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {

	}
}
