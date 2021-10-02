//
//  ViewController.swift
//  TrendingMoviesApp
//
//  Created by Tomiris on 23.04.2021.
//

import UIKit
import Alamofire
import WebKit

class TrendingMoviesViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    private var pageNumber: Int = 1
    private let TrendingMoviesURL = "https://newsapi.org/v2/top-headlines?country=us&apiKey=e8e76d56a81341428a1e107a3607d2e4"
    private var movies: [MovieEntity.Movie] = [MovieEntity.Movie]() {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: MovieCell.identifier, bundle: Bundle(for: MovieCell.self)), forCellReuseIdentifier: MovieCell.identifier)
        
        getTrendingMovies()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }
}


extension TrendingMoviesViewController {
    private func getTrendingMovies(_ page: Int? = nil) {
        var params: [String: Any] = [:]
        if let page = page {
            params["page"] = page
        }
        
        AF.request(TrendingMoviesURL, method: .get, parameters: params).responseJSON{[weak self ] (response) in switch response.result{
            case .success:
                if let data = response.data{
                    do{
                        let moviesJSON = try JSONDecoder().decode(MovieEntity.self, from: data)
                        self?.movies += moviesJSON.movies
                    } catch let JSONError{
                        print(JSONError)
                    }
                }
            case .failure:
                print("TrendingMoviesURL failed to send JSON")
            }
        }
    }
}


extension TrendingMoviesViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let vc = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController{
            vc.movieURL = movies[indexPath.row].url
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentoffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let deltaOffset = maximumOffset - currentoffset

        if deltaOffset >= 10 && deltaOffset < 200 {
            pageNumber += 1
            getTrendingMovies(pageNumber)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == movies.count - 1 {
            
        }
    }

}


extension TrendingMoviesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        cell.movie = movies[indexPath.row]
        cell.ratingLabel.text = "\(indexPath.row + 1)."
        return cell
    }
}
 
