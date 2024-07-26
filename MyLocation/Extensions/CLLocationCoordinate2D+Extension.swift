//
//  CLLocationCoordinate2D+Extension.swift
//  MyLocation
//
//  Created by Artyom Petrichenko on 26.07.2024.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
