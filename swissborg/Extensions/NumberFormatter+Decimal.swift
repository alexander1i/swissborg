//
//  NumberFormatter+Decimal.swift
//  swissborg
//
//  Created by Alexander Lisovyk on 09.07.22.
//

import Foundation

public extension NumberFormatter {
    static var decimalFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.decimalSeparator = "."
        formatter.groupingSeparator = ""
        formatter.usesGroupingSeparator = false
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 8
        formatter.roundingMode = .down
        formatter.numberStyle = .decimal
        return formatter
    }

    static var fiatDecimalFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.decimalSeparator = "."
        formatter.groupingSeparator = ""
        formatter.usesGroupingSeparator = false
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 2
        formatter.roundingMode = .down
        formatter.numberStyle = .decimal
        return formatter
    }
}
