//
//  FetchTraidingPairsRepository.swift
//  swissborg
//
//  Created by Alexander Lisovyk on 25.06.22.
//

import Foundation
import Combine
import Moya

final class FetchTraidingPairsRepository: FetchTraidingPairsRepositoryProtocol {
    let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchTraidingPairs(cryptoSymbols: [String], fiatSymbol: String) -> AnyPublisher<[[Any]]?, MoyaError> {
        return networkService.fetchTraidingPairs(cryptoSymbols: cryptoSymbols, fiatSymbol: fiatSymbol)
    }
}
