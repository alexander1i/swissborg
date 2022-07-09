//
//  Target.swift
//  swissborg
//
//  Created by Alexander Lisovyk on 25.06.22.
//

import Foundation
import Moya

enum Target {
    case traidingPairs(symbols: [String])
}

extension Target: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://api-pub.bitfinex.com/v2/") else {
            fatalError()
        }
        return url
    }
    
    var path: String {
        switch self {
        case .traidingPairs:    return "tickers"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .traidingPairs(let symbols):   return .requestParameters(parameters: ["symbols": symbols.joined(separator: ",")], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}
