//
//  StationView.swift
//  Toronto Bike Share
//
//  Created by Domenic Bianchi on 2018-01-03.
//  Copyright © 2018 Domenic Bianchi. All rights reserved.
//

import Foundation
import MapKit

final class StationAnnotationView: MKMarkerAnnotationView {
    // MARK: Properties
    private var customCalloutView: StationCalloutView? = nil
    override var annotation: MKAnnotation? {
        willSet {
            configure(with: newValue)
            canShowCallout = false
        }
    }
    
    // MARK: - MKMarkerAnnotationView Functions
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.customCalloutView?.removeFromSuperview()
        if selected {
            guard let newCustomCalloutView = loadStationCallout() else {
                return
            }
            newCustomCalloutView.frame.origin.x -= newCustomCalloutView.frame.width / 2.0 - (self.frame.width / 2.0)
            newCustomCalloutView.frame.origin.y -= newCustomCalloutView.frame.height + 45
            
            self.addSubview(newCustomCalloutView)
            self.customCalloutView = newCustomCalloutView
            
            if animated {
                self.customCalloutView?.alpha = 0.0
                UIView.animate(withDuration: 0.5, animations: {
                    self.customCalloutView?.alpha = 1.0
                })
            }
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let parentHitView = super.hitTest(point, with: event) {
            return parentHitView
        } else if customCalloutView != nil {
            return customCalloutView!.hitTest(convert(point, to: customCalloutView!), with: event)
        } else {
            return nil
        }
    }
    
    // MARK: - Helper Functions
    private func configure(with annotation: MKAnnotation?) {
        guard annotation is Station else {
            return
        }
        clusteringIdentifier = String(describing: StationAnnotationView.self)
        markerTintColor = UIColor(red: 24/255, green: 168/255, blue: 87/255, alpha: 1.0)
        titleVisibility = .adaptive
        glyphImage = #imageLiteral(resourceName: "Bike")
    }
    
    private func loadStationCallout() -> StationCalloutView? {
        if let annotation = annotation, let view = (Bundle.main.loadNibNamed("StationCalloutView", owner: self, options: nil) as? [StationCalloutView])?.first {
            view.configureView(for: annotation)
            return view
        }
        return nil
    }
}
