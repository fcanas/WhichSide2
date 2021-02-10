//
//  Time.swift
//  Sides WatchKit Extension
//
//  Created by Fabián Cañas on 2/10/21.
//

import Foundation

extension TimeInterval {
    var minutes: TimeInterval {
        return self * 60
    }
    
    var hours: TimeInterval {
        return minutes * 60
    }
}
