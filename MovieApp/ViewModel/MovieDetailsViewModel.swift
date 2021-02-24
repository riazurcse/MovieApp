//
//  MovieDetailsViewModel.swift
//  MovieApp
//
//  Created by Riajur Rahman on 24/2/21.
//

import Foundation

class MovieDetailsViewModel {
    
    var title: String?
    var poster: String?
    var year: String?
    var genre: String?
    var director: String?
    var writer: String?
    var actors: String?
    var plot: String?
    var language: String?
    var country: String?
    var awards: String?
    var ratings: [Rating]?
    var metascore: String?
    var imdbRating: String?
    var imdbVotes: String?
    var boxOffice: String?
    var production: String?
    var rated: String?
    var released: String?
    var runtime: String?
    
    init() {}
    
    init(model: MovieInfo) {
        self.title = model.title
        self.poster = model.poster
        self.year = model.year
        self.genre = model.genre
        self.director = model.director
        self.writer = model.writer
        self.actors = model.actors
        self.plot = model.plot
        self.language = model.language
        self.country = model.country
        self.awards = model.awards
        self.ratings = model.ratings
        self.metascore = model.metascore
        self.imdbRating = model.imdbRating
        self.imdbVotes = model.imdbVotes
        self.boxOffice = model.boxOffice
        self.production = model.production
        self.rated = model.rated
        self.released = model.released
        self.runtime = model.runtime
    }
    
    func getActors() -> [String]? {
        return self.actors?.components(separatedBy: ",")
    }
    
    func getDirectors() -> [String]? {
        return self.director?.components(separatedBy: ",")
    }
    
    func getWriters() -> [String]? {
        return self.writer?.components(separatedBy: ",")
    }
    
    func movieDetails(imdbId: String, completion: @escaping ((MovieDetailsViewModel?) -> ())) {
        let queryString = String(format: "i=%@", imdbId)
        ProgressHUD.sharedInstance.show(withTitle: "Please wait...")
        Service.shared.loadMovieDetails(queryParams: queryString) { (movieInfo, error) in
            ProgressHUD.sharedInstance.hide()
            if error == nil && movieInfo != nil {
                completion(MovieDetailsViewModel(model: movieInfo!))
            } else {
                completion(nil)
            }
        }
    }
}
