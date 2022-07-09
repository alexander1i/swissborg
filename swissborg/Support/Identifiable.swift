//
//  Identifiable.swift
//  swissborg
//
//  Created by Alexander Lisovyk on 25.06.22.
//

import Foundation

protocol Identifiable: AnyObject {
    static var identifier: String { get }
}

extension Identifiable {
    static var identifier: String {
        String(describing: self)
    }
}
