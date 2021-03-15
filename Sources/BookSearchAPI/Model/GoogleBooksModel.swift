//
//  GoogleBooksModel.swift
//  
//
//  Created by Benjamin Bruch on 10.03.21.
//

import Foundation

struct GoogleBooks: Codable {
    let kind: String
    let totalItems: Int?
    let items: [GoogleBook]?
}

struct GoogleBook: Codable {
    let volumeInfo: VolumeInfo
}

struct VolumeInfo: Codable {
    let title: String?
    let subtitle: String?
    let authors: [String]?
    let publishedDate: String?
    let description: String?
    let industryIdentifiers: [GoogleBookIndustryIdentifier]?
    let pageCount: Int?
    let categories: [String]?
    let imageLinks: GoogleBookImageLinks?
    let language: String?
}

struct GoogleBookIndustryIdentifier: Codable {
    let type: String?
    let identifier: String?
}

struct GoogleBookImageLinks: Codable {
    let smallThumbnail: String?
    let thumbnail: String?
}
