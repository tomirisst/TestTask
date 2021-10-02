//
//  MovieDetailsViewController.swift
//  TrendingMoviesApp
//
//  Created by Tomiris private on 23.04.2021.
//

import UIKit
import Alamofire
import Kingfisher
import WebKit

class MovieDetailsViewController: UIViewController, WKNavigationDelegate {

    
    @IBOutlet var webKitView: WKWebView!
    
    
    public var movieURL: String? {
        didSet{
            if let movieURL = movieURL{
                print(movieURL)
                webKitView = WKWebView()
                webKitView.navigationDelegate = self
                view = webKitView
                let url = URL(string: movieURL)
                let request = URLRequest(url: url!)
                webKitView.load(request)
                webKitView.allowsBackForwardNavigationGestures = true
            }
        }
    }
    

    
//    private func getMovieDetails(MovieURL: String) {
//        AF.request(MovieURL, method: .get, parameters: [:]).responseJSON{[weak self ] (response) in switch response.result{
//            case .success:
//                if let data = response.data{
//                    do{
//                        let moviesJSON = try JSONDecoder().decode(MovieDetails.self, from: data)
//                        self?.movie = moviesJSON
//                    } catch let JSONError{
//                        print(JSONError)
//                    }
//                }
//            case .failure:
//                print("MovieDetailsURL failed to send JSON")
//            }
//        }
//    }
}
