//
//  ApiError.swift
//  queroserMBcripto
//
//  Created by Ely Assumpcao Ndiaye on 04/05/25.
//

import Foundation

public enum ApiError: Error {
    case notFound
    case unauthorized
    case badRequest
    case tooManyRequests
    case otherErrors
    case connectionFailure
    case serverError
    case timeout
    case bodyNotFound
    case malformedRequest(_: String?)
    case decodeError(_: Error)
    case unknown(_: Error?)
    
    var message: String {
        switch self {
        case .timeout, .connectionFailure:
            return CriptoStrings.verifyYourConnection
        default:
            return CriptoStrings.tryAgainLater
        }
    }
}
