//
//  StationCluster.swift
//  Toronto Bike Share
//
//  Created by Domenic Bianchi on 2018-01-03.
//  Copyright © 2018 Domenic Bianchi. All rights reserved.
//

import Foundation
import MapKit

final class StationAnnotationCluster: MKAnnotationView {
    //MARK: Properties
    override var annotation: MKAnnotation? {
        willSet {
            configure(with: newValue)
        }
    }
    
    //MARK: Lifecycle Functions
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        displayPriority = .defaultLow
        collisionMode = .circle
        centerOffset = CGPoint(x: 0.0, y: -10.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Helper Functions
    private func configure(with annotation: MKAnnotation?) {
        guard let annotation = annotation as? MKClusterAnnotation else {
            return
        }
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 40.0, height: 40.0))
        image = renderer.image { _ in
            UIColor(red: 14/255, green: 102/255, blue: 52/255, alpha: 1.0).setFill()
            UIBezierPath(ovalIn: CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)).fill()
            let attributes: [NSAttributedStringKey : Any] = [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 17.0)]
            let text = "\(annotation.memberAnnotations.count)"
            let size = text.size(withAttributes: attributes)
            let rect = CGRect(x: 20 - size.width / 2, y: 20 - size.height / 2, width: size.width, height: size.height)
            text.draw(in: rect, withAttributes: attributes)
        }
    }
}
