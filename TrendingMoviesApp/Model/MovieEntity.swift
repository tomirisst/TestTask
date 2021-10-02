//
//  MovieEntity.swift
//  TrendingMoviesApp
//
//  Created by Tomiris on 23.04.2021.
//

import Foundation

struct MovieEntity: Decodable {
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "articles"
    }
    
    struct Movie: Decodable {
//        let id: String
        let author: String?
        let title: String
        let description: String?
        let poster: String?
        let releaseDate: String
        let content: String?
        let url: String
        
        enum CodingKeys: String, CodingKey {
//            case id = "id"
            case author = "author"
            case title = "title"
            case description = "description"
            case releaseDate = "publishedAt"
            case poster = "urlToImage"
            case content = "content"
            case url = "url"
        }
        
        init(movie: MovieEntityCD) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
//            self.id = movie.id!
            self.author = movie.author ?? "No author"
            self.title = movie.title!
            self.description = movie.description
            self.releaseDate = dateFormatter.string(from: movie.release_date ?? Date())
            self.content = movie.content ?? "No content"
            self.poster = movie.poster
            self.url = movie.url ?? "https://www.bbc.com"
        }
        
    }
}
