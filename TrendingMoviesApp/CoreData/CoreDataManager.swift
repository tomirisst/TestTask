//
//  CoreDataManager.swift
//  TrendingMoviesApp
//
//  Created by Tomiris on 21.05.2021.
//

import Foundation
import CoreData


class CoreDataManager {
    static let shared = CoreDataManager()
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "LocalDBModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private init() {}
    
    func save() {
        let context = persistentContainer.viewContext
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func addMovie(_ movie: MovieEntity.Movie) {
        let context = persistentContainer.viewContext
        
//        case id = "id"
//        case author = "author"
//        case title = "title"
//        case description = "description"
//        case releaseDate = "publishedAt"
//        case poster = "urlToImage"
//        case content = "content"
        
        context.perform {
            let newMovie = MovieEntityCD(context: context)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
//            newMovie.id = String(movie.id)
            newMovie.author = movie.author
            newMovie.title = movie.title
            newMovie.descriptionOfNews = movie.description
            newMovie.content = movie.content
            newMovie.poster = movie.poster
            newMovie.release_date = dateFormatter.date(from:movie.releaseDate)
            
        }
        save()
    }
    
    func addMovie(_ movie: MovieDetails) {
        let context = persistentContainer.viewContext
        
        context.perform {
            let newMovie = MovieEntityCD(context: context)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.dateFormat = "yyyy-MM-dd"
//            newMovie.id = String(movie.id)
            newMovie.author = movie.author
            newMovie.title = movie.title
            newMovie.descriptionOfNews = movie.description
            newMovie.content = movie.content
            newMovie.poster = movie.poster
            newMovie.release_date = dateFormatter.date(from:movie.releaseDate)
        }
        save()
    }
    
    func findMovie(with title: String) -> MovieEntityCD? {
        let context = persistentContainer.viewContext
        let requestResult: NSFetchRequest<MovieEntityCD> = MovieEntityCD.fetchRequest()
        requestResult.predicate = NSPredicate(format: "title == %d", title)
        do {
            let movies = try context.fetch(requestResult)
            if movies.count > 0 {
                assert(movies.count == 1, "Duplicate found in DB!")
                return movies[0]
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    func deleteMovie(with title: String) {
        let context = persistentContainer.viewContext
        if let movie = findMovie(with: title) {
            context.delete(movie)
        }
        save()
    }
    
    func allMovies() -> [MovieEntity.Movie] {
        let context = persistentContainer.viewContext
        let requestResult: NSFetchRequest<MovieEntityCD> = MovieEntityCD.fetchRequest()
        
        let movies = try? context.fetch(requestResult)
        
        
        return movies?.map({ MovieEntity.Movie(movie: $0)}) ?? []
    }
}
