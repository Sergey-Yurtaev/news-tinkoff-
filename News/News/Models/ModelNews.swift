//
//  ModelNews.swift
//  News
//
//  Created by Sergey Yurtaev on 05.02.2022.
//

import Foundation

struct News: Codable {
    let articles: [Article]?
}

struct Article: Codable {
    let author, title, articleDescription: String?
    let url: String
    let urlToImage: String
    let publishedAt: String?
    let content: String?
}

