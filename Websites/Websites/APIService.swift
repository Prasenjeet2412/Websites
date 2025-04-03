//
//  APIService.swift
//  Websites
//
//  Created by Prasenjeet Pandagale on 03/04/25.
//

import Foundation

struct APIService {
    static func submitForm(data: [String: Any], completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "API Example") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: data, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(NSError(domain: "Invalid response", code: 500, userInfo: nil)))
                return
            }
            
            completion(.success(()))
        }
        task.resume()
    }
}
