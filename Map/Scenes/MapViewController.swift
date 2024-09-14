//
//  ViewController.swift
//  Map
//
//  Created by Paulo Magro on 23/08/24.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    let mapView: MKMapView = {
        let mapView = MKMapView(frame: .zero)
        mapView.showsUserLocation = false
        mapView.showsUserTrackingButton = true
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        locationManager.delegate = self
        mapView.delegate = self
        mapView.register(ItemAnnotationView.self, forAnnotationViewWithReuseIdentifier: "\(ItemAnnotationView.self)")
    }

    private func setupView() {
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension MapViewController: CLLocationManagerDelegate, MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? ItemAnnotation else {
            return nil
        }
        
        let view = mapView.dequeueReusableAnnotationView(withIdentifier: "\(ItemAnnotationView.self)", for: annotation)
        if let view = view as? ItemAnnotationView {
            view.configure(annotation: annotation)
        }
        
        return view
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            mapView.showsUserLocation = true
            locationManager.requestLocation()
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 250, longitudinalMeters: 250)
            mapView.region = region
            let annotation = ItemAnnotation(item: .init(coordinate: coordinate, type: .found, description: "haveiro"))
            mapView.addAnnotation(annotation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

