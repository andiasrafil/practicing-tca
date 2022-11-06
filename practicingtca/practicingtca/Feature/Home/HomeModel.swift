//
//  HomeModel.swift
//  practicingtca
//
//  Created by TI Digital on 06/11/22.
//

import Foundation

struct HomeModel: Codable,Equatable {
    let status: String
    let totalResults: Int
    let articles: [Articles]
    
}

struct Articles: Sendable, Codable, Equatable, Identifiable {
    var id: UUID = UUID()
    
    static func == (lhs: Articles, rhs: Articles) -> Bool {
        lhs.title == rhs.title
    }
    
    let source: Source
        let author: String?
        let title: String
        let articleDescription: String?
        let url: String
        let urlToImage: String?
        let publishedAt: String
        let content: String?

        enum CodingKeys: String, CodingKey {
            case source, author, title
            case articleDescription = "description"
            case url, urlToImage, publishedAt, content
        }
}
struct Source: Codable {
    let id: String?
    let name: String
}

