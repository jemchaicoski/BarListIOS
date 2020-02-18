//
//  MapViewController.swift
//  deBarEmBar
//
//  Created by Jonathan on 17/02/20.
//  Copyright © 2020 hbsiscom.hbsis.padawan. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
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
      show(BarViewController(), sender: self)
        
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        
        
    }
    
    private func loadPoints(){
        bars = loadBars()!
        for bar in bars{
            mapView.addAnnotation(bar.barToAnotation())
            }
    }

    private func loadBars() -> [Bar]?  {
        let foto1 = UIImage(named: "BarImage1")
        let foto2 = UIImage(named: "BarImage2")
        let foto3 = UIImage(named: "BarImage3")
        let foto4 = UIImage(named: "BarImage4")
        let foto5 = UIImage(named: "BarImage5")
        let foto6 = UIImage(named: "BarImage6")
        
        guard let Bar1 =  Bar(nome: "Bar1", foto: foto1, telefone: "911111111", endereco: "Ribeirão Areia", coordenadaX: -26.9172369, coordenadaY: -49.0707435, rating: 5) else {
            fatalError("Unable to instantiate Bar1")
        }
        
        
        guard let Bar2 =  Bar(nome: "Bar2", foto: foto2, telefone: "922222222", endereco: "Ribeirão Solto", coordenadaX:  -26.9172710, coordenadaY: -49.0707490, rating: 2) else {
            fatalError("Unable to instantiate Bar2")
        }
        
        guard let Bar3 =  Bar(nome: "Bar3", foto: foto3, telefone: "9333333333", endereco: "Ribeirão Preto", coordenadaX: 0.0, coordenadaY: 0.0, rating: 5) else {
            fatalError("Unable to instantiate Bar3")
        }
        
        guard let Bar4 =  Bar(nome: "Bar4", foto: foto4, telefone: "944444444", endereco: "Testo Alto", coordenadaX: 0.0, coordenadaY: 0.0, rating: 3) else {
            fatalError("Unable to instantiate Bar4")
        }
        
        guard let Bar5 =  Bar(nome: "Bar5", foto: foto5, telefone: "955555555", endereco: "Testo Rega", coordenadaX: 0.0, coordenadaY: 0.0, rating: 4) else {
            fatalError("Unable to instantiate Bar5")
        }
        
        guard let Bar6 =  Bar(nome: "Bar6", foto: foto6, telefone: "966666666", endereco: "Testo Rega2", coordenadaX: 0.0, coordenadaY: 0.0, rating: 5) else {
            fatalError("Unable to instantiate Bar6")
        }
        
        
        return [Bar1, Bar2, Bar3, Bar4, Bar5, Bar6]
        //return NSKeyedUnarchiver.unarchiveObject(withFile: Bar.ArchiveURL.path) as? [Bar]
    }
    
    func mapView(_ mapView: MKMapView, didTapAt coordinate: CLLocationCoordinate2D) {
      // coordinate.latitude 
    }

}

