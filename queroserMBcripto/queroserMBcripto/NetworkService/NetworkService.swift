//
//  NetworkService.swift
//  queroserMBcripto
//
//  Created by Ely Assumpcao Ndiaye on 02/05/25.
//

import UIKit

protocol NetworkServiceProtocol {
    func getExchangeList(completion: @escaping (Result<[ExchangeModel], Error>) -> Void)
    func getExchangeImage(completion: @escaping (Result<[ExchangeImageModel], Error>) -> Void)
}


class NetworkService: NetworkServiceProtocol {
    private let baseURL = "https://rest.coinapi.io/v1"
    private let apiKey = "3807A772-1841-409F-B8DA-5A2E2110A687"
    
    func getExchangeList(completion: @escaping (Result<[ExchangeModel], Error>) -> Void) {
        let urlString = "\(baseURL)/exchanges"

        var request = URLRequest(url: URL(string: urlString)!)
        request.addValue(apiKey, forHTTPHeaderField: "X-CoinAPI-Key")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            guard let data = data else {
                let noDataError = NSError(domain: "NetworkServiceError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Nenhum dado recebido."])
                DispatchQueue.main.async {
                    completion(.failure(noDataError))
                }
                return
            }

            do {
                let decoder = JSONDecoder()
                let exchanges = try decoder.decode([ExchangeModel].self, from: data)
                DispatchQueue.main.async {
                    print(exchanges)
                    completion(.success(exchanges))
                }
            } catch let parseError {
                DispatchQueue.main.async {
                    completion(.failure(parseError))
                }
            }
        }

        task.resume()
    }
    
    func getExchangeImage(completion: @escaping (Result<[ExchangeImageModel], Error>) -> Void) {
        let urlString = "\(baseURL)/exchanges/icons/32"

        guard let url = URL(string: urlString) else {
            let invalidURLError = NSError(domain: "NetworkServiceError", code: 2, userInfo: [NSLocalizedDescriptionKey: "Error url invalida."])
            DispatchQueue.main.async {
                completion(.failure(invalidURLError))
            }
            return
        }

        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "X-CoinAPI-Key")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            guard let data = data else {
                let dataError = NSError(domain: "NetworkServiceError", code: 3, userInfo: [NSLocalizedDescriptionKey: "Dados não recebidos corretamente."])
                DispatchQueue.main.async {
                    completion(.failure(dataError))
                }
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let logos = try decoder.decode([ExchangeImageModel].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(logos))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }

        task.resume()
    }
    
    
}
