//
//  Article.swift
//  multi-sport-app
//
//  Created by Vincent Tran on 17/5/2022.
//

import Foundation

struct Article: Decodable {
    let source: Source?
    let author, title, welcomeDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
    enum CodingKeys: String, CodingKey {
        case source, author, title
        case welcomeDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}

struct Source: Codable {
    let id, name: String?
}



