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
    
    lazy var addButton = ButtonDefault(text: "", imageName: "plus", backgroundColor: .white.withAlphaComponent(0.95))
    
    lazy var mapPin = ImageDefault(image: "mappin.and.ellipse")
    
    let viewModel: MapViewModel
    let locationManager = CLLocationManager()
    var isAddingItem: Bool = false {
        didSet {
            updateAddMode()
        }
    }

    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupView()
        locationManager.delegate = self
        mapView.delegate = self
        mapView.register(ItemAnnotationView.self, forAnnotationViewWithReuseIdentifier: "\(ItemAnnotationView.self)")
        updateAddMode()
    }

    private func setupView() {
        view.addSubview(mapView)
        view.addSubview(addButton)
        view.addSubview(mapPin)
        addButton.addTarget(self, action: #selector(handleAdd), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            addButton.heightAnchor.constraint(equalToConstant: 44),
            addButton.widthAnchor.constraint(equalToConstant: 44),
            
            mapPin.centerXAnchor.constraint(equalTo: mapView.centerXAnchor),
            mapPin.centerYAnchor.constraint(equalTo: mapView.centerYAnchor),
            mapPin.heightAnchor.constraint(equalToConstant: 60),
            mapPin.widthAnchor.constraint(equalTo: mapPin.heightAnchor),
        ])
    }
    
    func updateAddMode () {
        if isAddingItem {
            addButton.isHidden = true
            mapPin.isHidden = false
        } else {
            addButton.isHidden = false
            mapPin.isHidden = true
        }
    }
    
    @objc
    func handleAdd() {
        viewModel.didTapAdd()
        isAddingItem = true
    }
            
    func addItem(type: ItemType, description: String) {
        let coordinate = mapView.centerCoordinate
        viewModel.add(item: .init(coordinate: coordinate, type: type, description: description))
        addAnnotationForLastItem()
    }
    
    func addAnnotationForLastItem() {
        if let item = viewModel.items.last {
            let annotation = ItemAnnotation(item: item)
            mapView.addAnnotation(annotation)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let view = view as? ItemAnnotationView, let annotation = view.annotation as? ItemAnnotation {
            mapView.removeAnnotation(annotation)
            viewModel.markAsReturned(item: annotation.item)
            addAnnotationForLastItem()
        }
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
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

