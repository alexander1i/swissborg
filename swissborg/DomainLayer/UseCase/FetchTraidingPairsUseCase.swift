//
//  FetchTraidingPairsUseCase.swift
//  swissborg
//
//  Created by Alexander Lisovyk on 25.06.22.
//

import Foundation
import Combine
import Moya

final class FetchTraidingPairsUseCase {
    private let repository: FetchTraidingPairsRepositoryProtocol

    init(repository: FetchTraidingPairsRepositoryProtocol) {
        self.repository = repository
    }

    func fetchTraidingPairs(cryptoSymbols: [String], fiatSymbol: String) -> AnyPublisher<[[Any]]?, MoyaError> {
        return repository.fetchTraidingPairs(cryptoSymbols: cryptoSymbols, fiatSymbol: fiatSymbol)
    }
}
