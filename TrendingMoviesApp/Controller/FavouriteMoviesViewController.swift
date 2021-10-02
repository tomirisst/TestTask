//
//  FavouriteMoviesViewController.swift
//  TrendingMoviesApp
//
//  Created by Tomiris on 21.05.2021.
//

import UIKit
protocol FavoriteMoviesDelegate {
    func updateMovies ()
}

class FavouriteMoviesViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    private var movies: [MovieEntity.Movie] = [] {
        didSet {
            if movies.count != oldValue.count {
                tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: MovieCell.identifier, bundle: Bundle(for: MovieCell.self)), forCellReuseIdentifier: MovieCell.identifier)

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.updateMovies()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FavouriteMoviesViewController: UITabBarDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        cell.movie = movies[indexPath.row]
        cell.delegate = self
        return cell
    }

    
}

extension FavouriteMoviesViewController: FavoriteMoviesDelegate{
    func updateMovies() {
        self.movies = CoreDataManager.shared.allMovies()
    }
    
}
