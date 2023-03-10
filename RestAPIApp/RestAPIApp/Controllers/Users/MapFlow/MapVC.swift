//
//  MapVC.swift
//  RestAPIApp
//
//  Created by comp on 27.12.22.
//

import UIKit
import MapKit

class MapVC: UIViewController {
    
    var address: Address?
    var users: [User] = []
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let lat = Double(address?.geo?.lat ?? ""), let lng = Double(address?.geo?.lng ?? "") else { return }
                 let initialLocation = CLLocation(latitude: lat, longitude: lng)
                 mapView.centerToLocation(initialLocation)
    }
}
    private extension MKMapView {
       func centerToLocation(_ location: CLLocation,regionRadius: CLLocationDistance = 1000) {
         let coordinateRegion = MKCoordinateRegion( center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
         setRegion(coordinateRegion, animated: true)
       }
    }
    
