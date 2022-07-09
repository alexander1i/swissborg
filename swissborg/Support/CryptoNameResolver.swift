//
//  CryptoNameResolver.swift
//  swissborg
//
//  Created by Alexander Lisovyk on 09.07.22.
//

import Foundation

enum CryptoNameResolver {
    static func resolveName(with symbol: String) -> String {
        switch symbol {
        case "BTC":     return "Bitcoin"
        case "ETH":     return "Ethereum"
        case "AAVE":    return "Aave"
        case "CHSB":    return "SwissBorg"
        case "DOGE":    return "Doge"
        case "EOS":     return "Eos.io"
        case "LTC":     return "Litecoin"
        case "MATIC":   return "Matic"
        case "XRP":     return "Ripple"
        default:        return "-"
        }
    }
}
