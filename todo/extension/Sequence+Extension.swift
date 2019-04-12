//
//  Sequence+Extension.swift
//  todo
//
//  Created by Adam Wlodarczyk on 28/03/2019.
//  Copyright © 2019 Adam Wlodarczyk. All rights reserved.
//

import Foundation
extension Sequence { 
    public func toDictionary<K: Hashable, V>(_ selector: (Iterator.Element) throws -> (K, V)?) rethrows -> [K: V] {
        var dict = [K: V]()
        for element in self {
            if let (key, value) = try selector(element) {
                dict[key] = value
            }
        }
        
        return dict
    }
}
