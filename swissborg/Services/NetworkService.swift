//
//  NetworkService.swift
//  swissborg
//
//  Created by Alexander Lisovyk on 25.06.22.
//

import Foundation
import Combine

import Moya
import CombineMoya

protocol NetworkService {
    var provider: MoyaProvider<Target> { get }

    func fetchTraidingPairs(cryptoSymbols: [String], fiatSymbol: String) -> AnyPublisher<[[Any]]?, MoyaError>
}
