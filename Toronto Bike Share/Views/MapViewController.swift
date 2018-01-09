//
//  MapViewController.swift
//  Toronto Bike Share
//
//  Created by Domenic Bianchi on 2018-01-03.
//  Copyright © 2018 Domenic Bianchi. All rights reserved.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var locationToolbar: UIToolbar!
    @IBOutlet var mapTypeSegmentedControl: UISegmentedControl!
    @IBOutlet var appInfoView: UIView!
    @IBOutlet var appInfoViewPositionConstraint: NSLayoutConstraint!
    @IBOutlet var etaViewPositionConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    private let locationManager = CLLocationManager()
    private var etaViewController: DirectionsViewController? = nil
    private var isETAViewOnScreen: Bool = false
    private var isAppInfoViewOnScreen: Bool = false
    
    // MARK: - Structs
    private struct Constants {
        static let directionsEtaSegue = "directionsETASegue"
        /// Value that allows the app info view to appear on the screen
        static let appInfoVisibleConstraintConstant: CGFloat = 295
        /// Value that allows the eta (with directions) view to appear on the screen
        static let etaViewVisibleConstraintConstant: CGFloat = 245
        /// Value that allows the eta (with directions) view to be placed ontop of the app info view
        static let etaViewWithAppInfoConstraintConstant: CGFloat = -250
    }
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapTypeSegmentedControl.enableScaleFactor()
        
        NotificationCenter.default.addObserver(self, selector: #selector(directionsRequested(_:)), name:
            .directionsRequested, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(clearDirections), name:
            .clearDirections, object: nil)
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        mapView.delegate = self
        mapView.register(StationAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.register(StationAnnotationCluster.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)

        fetchData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Notification Handlers
    @objc func directionsRequested(_ notification: Notification) {
        guard let directionsType = notification.userInfo?[NotificationKeys.directionsType] as? MKDirectionsTransportType,
            let destinationCoordinates = notification.userInfo?[NotificationKeys.destinationCoordinates] as? CLLocationCoordinate2D else {
            return
        }

        RouteDirectionsInteractor().calculateRoute(from: mapView.userLocation.coordinate, to: destinationCoordinates, by: directionsType) { response in
            self.mapView.removeOverlays(self.mapView.overlays)
            
            guard let unwrappedResponse = response,
                let route = unwrappedResponse.routes.first else {
                    self.displayErrorAlert()
                    return
            }

            if let etaViewController = self.etaViewController {
                etaViewController.route = route
                self.updateETAView(isHidden: false)
                self.updateAppInfoView()
            }
            
            self.mapView.add(route.polyline)
            let newRect = self.mapView.mapRectThatFits(route.polyline.boundingMapRect, edgePadding: UIEdgeInsetsMake(25, 25, 75, 25))
            self.mapView.setVisibleMapRect(newRect, animated: true)
        }
    }
    
    @objc func clearDirections() {
        updateETAView(isHidden: true)
        mapView.removeOverlays(mapView.overlays)
    }
    
    // MARK: - Helper Functions
    private func fetchData() {
        let dataProvider = StationInfoDataProvider()
        // Fetch the urls for the different feeds (station info, station status, pricing, etc)
        dataProvider.fetchBikeShareData(from: "https://tor.publicbikesystem.net/ube/gbfs/v1/", using: SystemFeeds.self) { systemFeeds in
            guard let systemFeeds = systemFeeds else {
                self.displayErrorAlert()
                return
            }
            // Fetch the station information
            dataProvider.fetchBikeShareData(from: systemFeeds.data.english.feeds[1].url, using: StationsInfo.self) { stations in
                guard let stations = stations else {
                    self.displayErrorAlert()
                    return
                }
                // Fetch the station statuses (number of available bikes, number of available racks, etc)
                dataProvider.fetchBikeShareData(from: systemFeeds.data.english.feeds[2].url, using: StationDetails.self) { statuses in
                    guard let statuses = statuses else {
                        self.displayErrorAlert()
                        return
                    }
                    var annotations: [Station] = []
                    for station in stations.data.stations {
                        guard let stationDetail = statuses.data.stations.first(where: { $0.id == station.id }) else {
                            continue
                        }
                        let annotation = Station(title: station.name,
                                                 coordinate: CLLocationCoordinate2D(latitude: station.lat, longitude: station.long),
                                                 stationDetail: stationDetail)
                        annotations.append(annotation)
                        self.mapView.addAnnotation(annotation)
                    }
                    self.mapView.showAnnotations(annotations, animated: true)
                }
            }
        }
    }
    
    private func displayErrorAlert() {
        let alertController = UIAlertController(title: "Error", message: "Unable to fetch data. Please try again later.", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: .default, handler: nil)

        alertController.addAction(cancelAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    private func updateETAView(isHidden: Bool) {
        if isHidden {
            isETAViewOnScreen = false
            etaViewPositionConstraint.constant = Constants.etaViewVisibleConstraintConstant
        } else if isAppInfoViewOnScreen {
            isETAViewOnScreen = true
            etaViewPositionConstraint.constant = Constants.etaViewWithAppInfoConstraintConstant
        } else {
            isETAViewOnScreen = true
            etaViewPositionConstraint.constant = 0
        }
        view.refreshView()
    }
    
    private func updateAppInfoView() {
        if isAppInfoViewOnScreen {
            isAppInfoViewOnScreen = false
            if isETAViewOnScreen {
                etaViewPositionConstraint.constant = 0
            }
            appInfoViewPositionConstraint.constant = Constants.appInfoVisibleConstraintConstant
            view.refreshView()
        }
    }
    
    // MARK: - IBActions
    @IBAction func infoButtonTapped(_ sender: Any) {
        if isAppInfoViewOnScreen {
            isAppInfoViewOnScreen = false
            if isETAViewOnScreen {
                etaViewPositionConstraint.constant = 0
            }
            appInfoViewPositionConstraint.constant = Constants.appInfoVisibleConstraintConstant
        } else {
            appInfoViewPositionConstraint.constant = 0
            isAppInfoViewOnScreen = true
        }
        updateETAView(isHidden: !isETAViewOnScreen)
        view.refreshView()
    }
    
    @IBAction func mapTypeChanged(_ sender: Any) {
        guard let segmentedControl = sender as? UISegmentedControl else {
            return
        }

        if segmentedControl.selectedSegmentIndex == 0 {
            mapView.mapType = .mutedStandard
        } else if segmentedControl.selectedSegmentIndex == 1 {
            mapView.mapType = .satellite
        } else {
            mapView.mapType = .hybrid
        }
    }
    
    @IBAction func screenTapped(_ sender: Any) {
        updateAppInfoView()
    }
    
    // MARK: - Segue Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.directionsEtaSegue {
            etaViewController = segue.destination as? DirectionsViewController
        }
    }
}

// MARK: - <MKMapViewDelegate>
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polylineRenderer = MKPolylineRenderer(overlay: overlay)
        polylineRenderer.strokeColor = view.tintColor
        polylineRenderer.lineWidth = 2
        return polylineRenderer
    }
}

// MARK: - <CLLocationManagerDelegate>
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            mapView.showsUserLocation = true
            let buttonItem = MKUserTrackingBarButtonItem(mapView: mapView)
            locationToolbar.items = [buttonItem]
        } else {
            mapView.showsUserLocation = false
            locationToolbar.items = nil
        }
    }
}
