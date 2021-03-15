//
//  File.swift
//  
//
//  Created by Benjamin Bruch on 11.03.21.
//

import Foundation

struct Book: Identifiable {
    let id = UUID()
    let title: String?
    let authors: [String]?
    let description: String?
    let coverURL: String?
}
