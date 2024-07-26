//
//  UserPointView.swift
//  MyLocation
//
//  Created by Artyom Petrichenko on 26.07.2024.
//

import Foundation
import MapKit

final class UserAnnotationView: MKAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        image = AnnotationImageBuilder.buildForUser()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct AnnotationImageBuilder {
    
    private static let imageSize: CGFloat = 32
    private static let strokeSize: CGFloat = 24
    
    static func buildForUser() -> UIImage {
        let outerCircleLayer = CALayer()
        outerCircleLayer.bounds = CGRect(x: 0, y: 0, width: imageSize, height: imageSize)
        outerCircleLayer.position = CGPoint(x: imageSize / 2, y: imageSize / 2)
        outerCircleLayer.cornerRadius = imageSize / 2
        outerCircleLayer.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2).cgColor
        
        let innerCircleLayer = CALayer()
        innerCircleLayer.bounds = CGRect(x: 0, y: 0, width: strokeSize - 4, height: strokeSize - 4)
        innerCircleLayer.position = outerCircleLayer.position
        innerCircleLayer.cornerRadius = (strokeSize - 4) / 2
        innerCircleLayer.backgroundColor = UIColor.white.cgColor
        
        let baseLayer = CALayer()
        baseLayer.bounds = outerCircleLayer.bounds
        baseLayer.addSublayer(outerCircleLayer)
        baseLayer.addSublayer(innerCircleLayer)
        
        let renderer = UIGraphicsImageRenderer(size: baseLayer.bounds.size)
        let image = renderer.image { context in
            baseLayer.render(in: context.cgContext)
        }
        
        return image
    }
}
