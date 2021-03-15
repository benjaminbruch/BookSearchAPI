//
//  BookSearchAPI.swift
//
//
//  Created by Benjamin Bruch on 11.03.21.
//
import Foundation
import Combine

enum SearchEngine: String {
    case google
}

struct SearchParams {
    let searchTerm: String
    let title: String
    let author: String
    let publisher: String
    let category: String
    let isbn: Int
    let language: String
    let maxResults: Int
}

class BookSearchAPIClient: ObservableObject {
    
    @Published var books: [Book] = []
    private var cancellables = [AnyCancellable]()
    private var baseURL: String = "https://www.googleapis.com"
    private var searchEngine: SearchEngine = .google
    
    
    func searchFor(searchEngine: SearchEngine = .google, searchTerm: String = "", bookTitle: String = "", bookAuthor: String = "",bookPublisher: String = "", bookCategory: String = "",  bookISBN: Int = -1, bookLanguage: String = "", maxResults: Int = -1) {
        
        let searchParams = SearchParams(searchTerm: searchTerm, title: bookTitle, author: bookAuthor, publisher: bookPublisher, category: bookCategory, isbn: bookISBN, language: bookLanguage, maxResults: maxResults)
        
        switch searchEngine {
        case .google:
            self.baseURL = "https://www.googleapis.com"
            self.searchEngine = .google
            let request = GoogleBooksRequest(searchParameter: searchParams)
            callAPI(request: request)
        }
    }
    
    private func callAPI<T: Request>(request: T) {
        APIClient(baseURL: baseURL).dispatch(request)
            // Observe for Returned values
            .sink(
                receiveCompletion: { result in
                    // Act on when we get a result or failure
                    switch result {
                    case .failure(let error):
                        // Handle API response errors here (WKNetworkRequestError)
                        print("Error loading data: \(error)")
                    default: break
                    }
                },
                receiveValue: { value in
                    var books: [Book] = []
                    switch self.searchEngine {
                    case .google:
                        let googleBooks = value as! GoogleBooks
                        googleBooks.items?.forEach { googleBook in
                            let book = Book(title: googleBook.volumeInfo.title, authors: googleBook.volumeInfo.authors, description: googleBook.volumeInfo.description, coverURL: googleBook.volumeInfo.imageLinks?.thumbnail)
                            books.append(book)
                        }
                        self.books = books
                    }
                })
            
            // Store the cancellable in a set (to hold a ref)
            .store(in: &cancellables)
    }
}



