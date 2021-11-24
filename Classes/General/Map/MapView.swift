//

import MapKit

//-----------------------------------------------------------------------------------------------------------------------------------------------
class MapView: UIViewController {

	@IBOutlet private var mapView: MKMapView!

	private var location: CLLocation!

	//-------------------------------------------------------------------------------------------------------------------------------------------
	init(location: CLLocation) {

		super.init(nibName: nil, bundle: nil)

		self.location = location
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	init(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {

		super.init(nibName: nil, bundle: nil)

		self.location = CLLocation(latitude: latitude, longitude: longitude)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	required init?(coder: NSCoder) {

		super.init(coder: coder)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func viewDidLoad() {

		super.viewDidLoad()
		title = "Map"

		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(actionDismiss))
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func viewWillAppear(_ animated: Bool) {

		super.viewWillAppear(animated)

		var region: MKCoordinateRegion = MKCoordinateRegion()
		region.center.latitude = location.coordinate.latitude
		region.center.longitude = location.coordinate.longitude
		region.span.latitudeDelta = CLLocationDegrees(0.01)
		region.span.longitudeDelta = CLLocationDegrees(0.01)
		mapView.setRegion(region, animated: false)

		let annotation = MKPointAnnotation()
		mapView.addAnnotation(annotation)
		annotation.coordinate = location.coordinate
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	@objc func actionDismiss() {

		dismiss(animated: true)
	}
}
