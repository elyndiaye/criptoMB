//
//  NetworkService.swift
//  queroserMBcripto
//
//  Created by Ely Assumpcao Ndiaye on 02/05/25.
//

import UIKit

protocol NetworkServiceProtocol {
    func getExchangeList(completion: @escaping (Result<[ExchangeModel], ApiError>) -> Void)
    func getExchangeImage(completion: @escaping (Result<[ExchangeImageModel], ApiError>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    private let baseURL = "https://rest.coinapi.io/v1"
    private let apiKey = "5c9da08a-2d38-42ae-ae2d-7020aae0caa5"

    func getExchangeList(completion: @escaping (Result<[ExchangeModel], ApiError>) -> Void) {
        let urlString = "\(baseURL)/exchanges"

        guard let url = URL(string: urlString) else {
            completion(.failure(.malformedRequest("URL inválida para getExchangeList")))
            return
        }

        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "X-CoinAPI-Key")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error as NSError? {
                let apiError: ApiError = {
                    if error.domain == NSURLErrorDomain {
                        switch error.code {
                        case NSURLErrorNotConnectedToInternet:
                            return .connectionFailure
                        case NSURLErrorTimedOut:
                            return .timeout
                        default:
                            return .unknown(error)
                        }
                    }
                    return .unknown(error)
                }()
                DispatchQueue.main.async {
                    completion(.failure(apiError))
                }
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(.unknown(nil)))
                }
                return
            }

            switch httpResponse.statusCode {
            case 200:
                break
            case 400:
                completion(.failure(.badRequest))
                return
            case 401:
                completion(.failure(.unauthorized))
                return
            case 404:
                completion(.failure(.notFound))
                return
            case 429:
                completion(.failure(.tooManyRequests))
                return
            case 500...599:
                completion(.failure(.serverError))
                return
            default:
                completion(.failure(.otherErrors))
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(.bodyNotFound))
                }
                return
            }

            do {
                let decoder = JSONDecoder()
                let exchanges = try decoder.decode([ExchangeModel].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(exchanges))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.decodeError(error)))
                }
            }
        }

        task.resume()
    }

    func getExchangeImage(completion: @escaping (Result<[ExchangeImageModel], ApiError>) -> Void) {
        let urlString = "\(baseURL)/exchanges/icons/32"

        guard let url = URL(string: urlString) else {
            completion(.failure(.malformedRequest("URL inválida para getExchangeImage")))
            return
        }

        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "X-CoinAPI-Key")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error as NSError? {
                let apiError: ApiError = {
                    if error.domain == NSURLErrorDomain {
                        switch error.code {
                        case NSURLErrorNotConnectedToInternet:
                            return .connectionFailure
                        case NSURLErrorTimedOut:
                            return .timeout
                        default:
                            return .unknown(error)
                        }
                    }
                    return .unknown(error)
                }()
                DispatchQueue.main.async {
                    completion(.failure(apiError))
                }
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(.unknown(nil)))
                }
                return
            }

            switch httpResponse.statusCode {
            case 200:
                break
            case 400:
                completion(.failure(.badRequest))
                return
            case 401:
                completion(.failure(.unauthorized))
                return
            case 404:
                completion(.failure(.notFound))
                return
            case 429:
                completion(.failure(.tooManyRequests))
                return
            case 500...599:
                completion(.failure(.serverError))
                return
            default:
                completion(.failure(.otherErrors))
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(.bodyNotFound))
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
                    completion(.failure(.decodeError(error)))
                }
            }
        }

        task.resume()
    }
}
