//
//  NetworkManager.swift
//  WidgetApp
//
//  Created by Татьяна Балашенко on 29.09.21.
//

import Foundation

final class NetworkManager {
    enum ErrorType: Error {
        case badURL, requestFailed, decodingFailed
    }
    
    static let shared = NetworkManager()
    
    func request<T: Decodable>(from urlString: String, completion: @escaping (Result<T, ErrorType>) -> ()) {
        guard let url = URL(string: urlString) else { completion(.failure(.badURL)); return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else { completion(.failure(.requestFailed)); return }
            
            if let data = data, let response = try? JSONDecoder().decode(T.self, from: data) {
                completion(.success(response))
            } else {
                completion(.failure(.decodingFailed))
            }
        }.resume()
    }
}
