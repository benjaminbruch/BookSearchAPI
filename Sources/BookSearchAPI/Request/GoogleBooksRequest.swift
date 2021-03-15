//
//  GoogleBooksRequest.swift
//  
//
//  Created by Benjamin Bruch on 11.03.21.
//

import Foundation


struct GoogleBooksRequest: Request {
    let searchParameter: SearchParams
    var queryItems: [URLQueryItem]? { return [URLQueryItem(name: "q", value: generateSearchParameterString())] }
    let path: String = "/books/v1/volumes"
    typealias ReturnType = GoogleBooks
    
    func generateSearchParameterString() -> String {
        var searchQueryString = ""
        
        if searchParameter.searchTerm.isEmpty == false {
            searchQueryString.append(searchParameter.searchTerm)
        }
        
        if searchParameter.title.isEmpty == false {
            searchQueryString.append("+intitle:\(searchParameter.title)")
        }
        
        if searchParameter.author.isEmpty == false {
            searchQueryString.append("+inauthor:\(searchParameter.author)")
        }
        
        if searchParameter.publisher.isEmpty == false {
            searchQueryString.append("+inpublisher:\(searchParameter.title)")
        }
        
        if searchParameter.category.isEmpty == false {
            searchQueryString.append("+subject:\(searchParameter.category)")
        }
        
        if searchParameter.isbn > 0 {
            searchQueryString.append("+isbn:\(searchParameter.isbn)")
        }
        
        if searchParameter.language.isEmpty == false {
            searchQueryString.append("&langRestrict=\(searchParameter.language)")
        }
        
        if searchParameter.maxResults > 0 {
            searchQueryString.append("&maxResults=\(searchParameter.maxResults)")
        }
        
        return searchQueryString
    }
}




