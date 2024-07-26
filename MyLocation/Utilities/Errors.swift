//
//  Errors.swift
//  MyLocation
//
//  Created by Artyom Petrichenko on 26.07.2024.
//

import Foundation

enum LocationError: Error {
    case locationUnknown
    case locationServicesDisabled

    var localizedDescription: String {
        switch self {
        case .locationUnknown:
            return "Не удается определить локацию"
        case .locationServicesDisabled:
            return "Геолокация отключена"
        }
    }
}
