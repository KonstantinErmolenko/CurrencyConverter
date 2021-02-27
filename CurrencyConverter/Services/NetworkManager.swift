//
//  NetworkManager.swift
//  CurrencyConverter
//
//  Created by Ермоленко Константин on 25.02.2021.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    private let baseUrl = "https://api.exchangeratesapi.io"
    
    private init() {}
    
    func fetchCurrencyRate(exchange: CurrencyExchange, complition: @escaping (CurrencyExchange, Double) -> Void) {
        var urlComponents = URLComponents(string: baseUrl + "/latest")!
        urlComponents.queryItems = parameters(exchange: exchange)
        guard let url = urlComponents.url else {
            complition(exchange, 0.0)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                complition(exchange, 0.0)
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200..<300).contains(response.statusCode) else {
                complition(exchange,0.0)
                return
            }
            
            guard let data = data else {
                complition(exchange, 0.0)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(ServerResponse.self, from: data)
                let rate = decodedResponse.rates[exchange.forCurrency.id] ?? 0.0
                complition(exchange, rate)
                return
            } catch {
                complition(exchange, 0.0)
                return
            }
        }
        task.resume()
    }
}

struct ServerResponse: Decodable {
    let rates: [String: Double]
    let base: String
    let date: String
}


private func parameters(exchange: CurrencyExchange) -> [URLQueryItem] {
    let base = URLQueryItem(name: "base",
                            value: exchange.fromCurrency.id)
    let symbols = URLQueryItem(name: "symbols",
                               value: exchange.forCurrency.id)
    return [base, symbols]
}
