//
//  NetworkManager.swift
//  CurrencyConverter
//
//  Created by Ермоленко Константин on 25.02.2021.
//

import Foundation
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    private let baseUrl = "https://api.exchangeratesapi.io"
    private init() {}
    
    func fetchCurrencyRate(
        exchange: CurrencyExchange,
        complition: @escaping (CurrencyExchange, Double) -> Void) {
        
        let url = baseUrl + "/latest"
        let parameters: [String: String] = [
            "base": exchange.fromCurrency.id,
            "symbols": exchange.forCurrency.id
        ]
        
        AF.request(url, parameters: parameters)
            .validate()
            .responseDecodable(of: ServerResponse.self) { response in
                guard let value = response.value else {
                    complition(exchange, 0.0)
                    return
                }
                let rate = value.rates[exchange.forCurrency.id] ?? 0.0
                complition(exchange, rate)
            }
    }
}

struct ServerResponse: Decodable {
    let rates: [String: Double]

    enum CodingKeys: CodingKey {
        case rates
    }
}
