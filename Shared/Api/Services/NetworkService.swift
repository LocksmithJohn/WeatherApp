//
//  NetworkService.swift
//  iOSWeatherApp
//
//  Created by Jan Ślusarz on 08/05/2021.
//

import Combine
import Foundation

protocol NetworkService {
    
    func request<T: Decodable>(request: URLRequest) -> AnyPublisher<T, Error>
    
}

extension NetworkService {

    func request<T>(request: URLRequest) -> AnyPublisher<T, Error> where T : Decodable {
        let decoder = JSONDecoder()
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap {
                guard let r = $0.response as? HTTPURLResponse,
                      r.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                
                return $0.data
            }
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
}
