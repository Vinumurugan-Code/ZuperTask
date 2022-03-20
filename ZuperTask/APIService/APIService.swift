//
//  APIService.swift
//  ZuperTask
//
//  Created by vinumurugan E on 17/03/22.
//

import Foundation
import UIKit

typealias JSON = [String:Any]
typealias HTTPHeaders = [String:String]

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum Result<Value> {
    case success(Value)
    case failure(Error)
}

class APIService: NSObject {
    
    let baseURL = "http://167.71.235.242:3000/todo"
    
    static let shared = APIService()
    
   private func apiRequest(_ url:String, method:RequestMethod, headers:HTTPHeaders? = nil, body:JSON? = nil, completionHandler: @escaping(Data?, URLResponse?, Error?) -> Void) {
        
        let url = URL(string: url)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let body = body {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject:body)
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlRequest) {data, response, error in
            completionHandler(data, response, error)
        }
        task.resume()
    }
    
    
    func request<T: Decodable>(for: T.Type = T.self, url: String, method: RequestMethod, headers: HTTPHeaders? = nil, body: JSON? = nil, completion: @escaping(Result<T>) -> Void) {
        
        return apiRequest(url, method: method, headers: headers, body: body) { (data, response, error) in
            guard let data = data else {
                return completion(.failure(error ?? NSError(domain: "Something wrong", code: -1, userInfo: nil)))
            }
            do {
                let decorder = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decorder))
            } catch let decodingError {
                completion(.failure(decodingError))
            }
        }
    }
}
