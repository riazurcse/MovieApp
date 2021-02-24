//
//  MovieViewModel.swift
//  MovieApp
//
//  Created by Riajur Rahman on 23/2/21.
//

import Foundation

class MovieViewModel {
    
    var title: String?
    var poster: String?
    var imdbID: String?
    
    private (set) var searchType: SearchType = .movie
    private (set) var searchText: String?
    private (set) var totalResults: Int?
    
    private var movies = [MovieViewModel]()
    
    init() {}
    
    init(model: Movie) {
        self.title = model.title
        self.poster = model.poster
        self.imdbID = model.imdbID
    }
    
    func setSearchType(type: SearchType) {
        searchType = type
    }
    
    func setSearchText(text: String?) {
        searchText = text
    }
    
    public func reset() {
        movies = [MovieViewModel]()
    }
    
    public func searchedMovies() -> [MovieViewModel] {
        return movies
    }
    
    public func gettotalResults() -> Int {
        return totalResults ?? 0
    }
    
    func searchMovie(searchKey: String, type: SearchType = .movie, pageNumber: Int, completion: @escaping (() -> ())) {
        let queryString = String(format: "s=%@&type=%@&page=%d", searchKey, type.rawValue, pageNumber)
        ProgressHUD.sharedInstance.show(withTitle: "Please wait...")
        Service.shared.loadMovies(queryParams: queryString) { (movies, totalResults, error) in
            ProgressHUD.sharedInstance.hide()
            if let _total = totalResults {
                self.totalResults = Int(_total)
            }
            for movie in movies ?? [] {
                self.movies.append(MovieViewModel(model: movie))
            }
            completion()
        }
    }
}
