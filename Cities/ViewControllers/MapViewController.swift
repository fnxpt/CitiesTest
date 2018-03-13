import MapKit
import UIKit

class MapViewController: UIViewController {
    
    @IBOutlet fileprivate weak var mapView: MKMapView!
    var city: City?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let city = city {
            
            title = city.name
            mapView.centerCoordinate = city.coordinate
        }
    }
}
