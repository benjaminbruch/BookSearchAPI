//
//  Request.swift
//
//  Created by Benjamin Bruch on 10.03.21.
//

import Foundation

public enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
}

public protocol Request {
    var path: String { get }
    var method: HTTPMethod { get }
    var contentType: String { get }
    var body: [String: Any]? { get }
    var headers: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    associatedtype ReturnType: Codable
}

extension Request {
    var method: HTTPMethod { .get }
    var contentType: String { return "application/json" }
    var body: [String: Any]? { return nil }
    var headers: [String: String]? { return nil }
}

extension Request {
    
    /// Serializes an HTTP dictionary to a JSON Data Object
    /// - Parameter params: HTTP Parameters dictionary
    /// - Returns: Encoded JSON
    private func requestBodyFrom(params: [String: Any]?) -> Data? {
        guard let params = params else { return nil }
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
            return nil
        }
        return httpBody
    }
    
    /// Transforms a Request into a standard URL request
    /// - Parameter baseURL: API Base URL to be used
    /// - Returns: A ready to use URLRequest
    func asURLRequest(baseURL: String) -> URLRequest? {
        guard var urlComponents = URLComponents(string: baseURL) else { return nil }
        urlComponents.path = "\(urlComponents.path)\(path)"
        urlComponents.queryItems = queryItems
        guard let requestURL = urlComponents.url else { return nil }
        
        print(requestURL.absoluteString.removingPercentEncoding ?? "Could not print URL")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        request.httpBody = requestBodyFrom(params: body)
        request.allHTTPHeaderFields = headers
        return request
    }
}



