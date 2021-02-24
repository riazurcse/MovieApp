//
//  Movie.swift
//  MovieApp
//
//  Created by Riajur Rahman on 23/2/21.
//

import Foundation

enum SearchType: String, CaseIterable {
    case movie
    case series
    case episode
}

class Root: Decodable {
    var movies: [Movie]?
    var totalResults: String?
    
    enum CodingKeys: String, CodingKey {
        case Search
        case totalResults
    }
    
    public required init(from decoder: Decoder) {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.movies = try container.decode([Movie].self, forKey: .Search)
            self.totalResults = try container.decode(String.self, forKey: .totalResults)
        } catch let error {
            print(error)
        }
    }
}

class Movie: Decodable {

    var title: String?
    var year: String?
    var imdbID: String?
    var type: SearchType = .movie
    var poster: String?
    
    enum CodingKeys: String, CodingKey {
        case Title
        case Year
        case imdbID
        case type = "Type"
        case Poster
    }
    
    public required init(from decoder: Decoder) {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.title = try container.decode(String.self, forKey: .Title)
            self.year = try container.decode(String.self, forKey: .Year)
            self.imdbID = try container.decode(String.self, forKey: .imdbID)
            self.type = SearchType.init(rawValue: try container.decode(String.self, forKey: .type))!
            self.poster = try container.decode(String.self, forKey: .Poster)
        } catch let error {
            print(error)
        }
    }
}
