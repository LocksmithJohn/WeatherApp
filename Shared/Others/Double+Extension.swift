//
//  Double+Extension.swift
//  iOSWeatherApp
//
//  Created by Jan Ślusarz on 09/05/2021.
//

import Foundation

extension Double {
    
    func fromKelvinToCelsius() -> Int {
        Int(self - 272.15)
    }
    
}
