//
//  AppError.swift
//  multi-sport-app
//
//  Created by Vincent Tran on 15/5/2022.
//

import Foundation

enum AppError: LocalizedError {
    case errorDecoding
    case unknownError
    case invalidUrl
    case noData
    //case serverError(String)
    case serverError
    
    var errorDescription: String? {
        switch self {
        case .errorDecoding:
            return "Response could not be decoded"
        case .unknownError:
            return "Unknown error occurred"
        case .invalidUrl:
            return "Invalid url"
        case .noData:
            return "No data found when decoding"
//        case .serverError(let error):
//            return error
        case .serverError:
            return "Error on server"
        }
    }
}
