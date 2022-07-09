//
//  ProductionNetworkService.swift
//  swissborg
//
//  Created by Alexander Lisovyk on 25.06.22.
//

import Foundation
import Combine

import Moya
import CombineMoya


final class ProductionNetworkService: NetworkService {
    var provider = MoyaProvider<Target>()

    func fetchTraidingPairs(cryptoSymbols: [String], fiatSymbol: String) -> AnyPublisher<[[Any]]?, MoyaError> {
        let symbols = cryptoSymbols.map { "t\($0)\(fiatSymbol)" }
        return request(target: .traidingPairs(symbols: symbols))
            .map { response -> [[Any]]? in
                return try? JSONSerialization.jsonObject(with: response.data, options: []) as? [[Any]]
            }
            .eraseToAnyPublisher()
    }
}

private extension ProductionNetworkService {
    private func request(target: Target) -> AnyPublisher<Response, MoyaError> {
        provider.requestPublisher(target)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
