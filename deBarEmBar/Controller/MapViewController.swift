//
//  MapViewController.swift
//  deBarEmBar
//
//  Created by Jonathan on 17/02/20.
//  Copyright © 2020 hbsiscom.hbsis.padawan. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController{
    let regionRadius: CLLocationDistance = 1000
    @IBOutlet weak var mapView: MKMapView!
    
    //points
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set initial location in Proway
        let initialLocation = CLLocation(latitude: -26.9172369, longitude: -49.0707435)
        centerMapOnLocation(location: initialLocation)
        loadPoints()
        //loop carrefar os pontos
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    @IBAction func longPressMap(_ sender: Any) {
        DispatchQueue.main.async(){self.performSegue(withIdentifier: "NovoBarDoMapa", sender: self)}
        
    }
    
    private func loadPoints(){
        //bars = loadBars()!
        for bar in bars{
            mapView.addAnnotation(bar.barToAnotation())
            }
    }
    
    func mapView(_ mapView: MKMapView, didTapAt coordinate: CLLocationCoordinate2D) {
      // coordinate.latitude 
    }

}

