//
//  NetworkManager.swift
//  newMTB
//
//  Created by Татьяна Балашенко on 10.05.21.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    enum MWNetworkError {
        case incorrectUrl
        case networkError(error: Error)
        case frontError(statusCode: Int)
        case serverError(statusCode: Int)
        case parsingError(error: Error)
        case unknown
    }
    
    func request<T: Decodable>(url: String, successHandler: @escaping (T) -> Void, errorHandler: @escaping (MWNetworkError) -> Void) {
        AF.request(url).responseJSON(completionHandler: { (response) in
            if let error = response.error {
                errorHandler(.networkError(error: error))
                return
            } else if let data = response.data,
                      let httpResponse = response.response {
                switch httpResponse.statusCode {
                    case 200..<300:
                        do {
                            let response = try JSONDecoder().decode(T.self, from: data)
                            successHandler(response)
                        } catch let error {
                            errorHandler(.parsingError(error: error))
                        }
                    case 400..<500:
                        errorHandler(.frontError(statusCode: httpResponse.statusCode))
                        break
                    case 500...:
                        errorHandler(.serverError(statusCode: httpResponse.statusCode))
                    default:
                        errorHandler(.unknown)
                }
            }
        })
    }
}
