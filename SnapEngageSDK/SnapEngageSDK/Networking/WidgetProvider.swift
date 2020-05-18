//
//  WidgetProvider.swift
//  SnapEngageSDK
//
//  Created by SnapEngage on 2020. 04. 29..
//  Copyright © 2020. SnapEngage. All rights reserved.
//

import Foundation

/// Class to fetch informatoin about the widget
class WidgetProvider {
    
    /// The base url for the HTTP call without the widgetId
    private let baseUrl: URL

    public init(baseUrl: URL) {
        self.baseUrl = baseUrl
    }
    
    /// You can get the status of the widget
    /// - Parameters:
    ///     - widgetId: The id of the widget
    ///     - completion: Completion cloesure with a result parameter. The result can contain the WidgetAvailability or an Error, which can be a ChatError
    func checkWidgetAvailability(widgetId: String, completion: @escaping (Result<WidgetAvailability, Error>) -> Void) {
        let url = self.baseUrl.appendingPathComponent(widgetId)
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
               completion(.failure(ChatError.httpError(url: url, statusCode: nil)))
                return
            }
            
            guard 200...299 ~= httpResponse.statusCode else {
                completion(.failure(ChatError.httpError(url: url, statusCode: httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(ChatError.noData(url: url)))
                return
            }
            
            do {
                let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                completion(.failure(ChatError.apiError(statusCode: errorResponse.statusCode, message: errorResponse.error.message)))
                return
            } catch {
                // continue parsing
            }
            
            do {
                let widgetResponse = try JSONDecoder().decode(WidgetAvailability.self, from: data)
                completion(.success(widgetResponse))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
}
