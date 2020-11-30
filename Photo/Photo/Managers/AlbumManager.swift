//
//  AlbumManager.swift
//  Photo
//
//  Created by TANYA GYGI on 11/30/20.
//

import Foundation
import Alamofire
import CoreLocation

protocol Albums_Protocol {
    func albums(completion: @escaping (Result<[Album], Error>) -> Void)
    func photos(_ albumId:Int, completion: @escaping (Result<[Photo], Error>) -> Void)
}

class AlbumsResult: Albums_Protocol {

    private let httpClient: HTTPClient_Protocol
    private let jsonDecoder: JSONDecoder
    
    init(httpClient: HTTPClient_Protocol = HTTPClient()) {
        self.httpClient = httpClient
        self.jsonDecoder = JSONDecoder()
        self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func photos(_ albumId: Int, completion: @escaping (Result<[Photo], Error>) -> Void) {

        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos?albumId=\(albumId)") else {
            let error = NSError(domain:"", code:123, userInfo:nil)
            completion(.failure(error))
            return
        }
        
        let request = HTTPRequest(url: url)
        httpClient.send(request: request) { result in
            switch result {
            case let .success(value):
                completion(Result(catching: {
                    try self.jsonDecoder.decode([Photo].self, from: value)}))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func albums(completion: @escaping (Result<[Album], Error>) -> Void) {

        guard let url = URL(string: "https://jsonplaceholder.typicode.com/albums") else {
            let error = NSError(domain:"", code:123, userInfo:nil)
            completion(.failure(error))
            return
        }
        
        let request = HTTPRequest(url: url)
        httpClient.send(request: request) { result in
            switch result {
            case let .success(value):
                completion(Result(catching: {
            
                    try! self.jsonDecoder.decode([Album].self, from: value)
 
                }))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
