import XCTest
import SwiftUI
import Combine
@testable import BookSearchAPI

final class BookSearchAPITests: XCTestCase {
    
    @ObservedObject var client = BookSearchAPIClient()
    var cancellable: AnyCancellable?
    
    func testSearchForSearchTerm() {
       // let expectation = XCTestExpectation(description: "Return books with specified search term")
        
        client.searchFor(searchEngine: .google, bookTitle: "Bibel", maxResults: 10)
     
        self.cancellable = client.$books.sink(receiveCompletion: {_ in print("yeahh")}, receiveValue: {book in print(book.first?.authors)})
        sleep(20)
        //wait(for: [expectation], timeout: 10.0)
    }
    
    static var allTests = [
        ("testSearchForSearchTerm", testSearchForSearchTerm),
    ]
}
