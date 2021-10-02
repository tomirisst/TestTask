//
//  MovieDetails.swift
//  TrendingMoviesApp
//
//  Created by Tomiris private on 23.04.2021.
//

import Foundation

struct MovieDetails: Decodable {
    
//    let id: String
    let author: String
    let title: String
    let description: String
    let poster: String?
    let releaseDate: String
    let content: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
//        case id = "id"
        case author = "author"
        case title = "title"
        case description = "description"
        case releaseDate = "publishedAt"
        case poster = "urlToImage"
        case content = "content"
        case url = "url"
    }
}
