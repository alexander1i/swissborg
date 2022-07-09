//
//  TraidingPairsPresenter.swift
//  swissborg
//
//  Created by Alexander Lisovyk on 25.06.22.
//

import Foundation

struct TraidingPairModel {
    let name: String
    let symbol: String
    let price: String
    let interest: String
}

protocol TraidingPairsPresenter {
    func updateTraidingPairs(traidingPairs: [[Any]], fiatSymbol: String)
    func showMessage(text: String)
}

final class TraidingPairsViewModel: TraidingPairsPresenter {
    @Published fileprivate(set) var traidingPairs = [TraidingPairModel]()
    @Published fileprivate(set) var toastMessage = ""
    
    fileprivate let numberFormatter: NumberFormatter = {
        return NumberFormatter.decimalFormatter
    }()
    
    func updateTraidingPairs(traidingPairs: [[Any]], fiatSymbol: String) {
        self.traidingPairs = traidingPairs.map { pair in
            let symbol = ((pair[0] as? String) ?? "")
                .replacingOccurrences(of: "t", with: "")
                .replacingOccurrences(of: fiatSymbol, with: "")

            let price = fiatSymbol + " " + String((pair[1] as? Double) ?? 0)
            let interestDouble = (pair[6] as? Double) ?? 0
            let interest = (interestDouble > 0 ? "+" : "") + String(interestDouble) + "%"
            
            return TraidingPairModel(
                name: CryptoNameResolver.resolveName(with: symbol),
                symbol: symbol,
                price: price,
                interest: interest
            )
        }
    }
    
    func showMessage(text: String) {
        toastMessage = text
    }
}
