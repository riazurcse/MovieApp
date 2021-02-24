//
//  MovieInfo.swift
//  MovieApp
//
//  Created by Riajur Rahman on 24/2/21.
//

import Foundation

class Rating: Decodable {
    
    var source: String?
    var value: String?
    
    enum CodingKeys: String, CodingKey {
        case Source
        case Value
    }

    public required init(from decoder: Decoder) {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.source = try container.decode(String.self, forKey: .Source)
            self.value = try container.decode(String.self, forKey: .Value)
        } catch let error {
            print(error)
        }
    }
}

class MovieInfo: Movie {
    
    var rated: String?
    var released: String?
    var runtime: String?
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
    var dvd: String?
    var boxOffice: String?
    var production: String?
    var website: String?
    
    enum CodingKeys: String, CodingKey {
        case Rated
        case Released
        case Runtime
        case Genre
        case Director
        case Writer
        case Plot
        case Actors
        case Language
        case Country
        case Awards
        case Ratings
        case Metascore
        case imdbRating
        case imdbVotes
        case DVD
        case BoxOffice
        case Production
        case Website
    }
    
    public required init(from decoder: Decoder) {
        super.init(from: decoder)
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.rated = try container.decode(String.self, forKey: .Rated)
            self.released = try container.decode(String.self, forKey: .Released)
            self.runtime = try container.decode(String.self, forKey: .Runtime)
            self.genre = try container.decode(String.self, forKey: .Genre)
            self.director = try container.decode(String.self, forKey: .Director)
            self.writer = try container.decode(String.self, forKey: .Writer)
            self.actors = try container.decode(String.self, forKey: .Actors)
            self.plot = try container.decode(String.self, forKey: .Plot)
            self.language = try container.decode(String.self, forKey: .Language)
            self.country = try container.decode(String.self, forKey: .Country)
            self.awards = try container.decode(String.self, forKey: .Awards)
            self.ratings = try container.decode([Rating].self, forKey: .Ratings)
            self.metascore = try container.decode(String.self, forKey: .Metascore)
            self.imdbRating = try container.decode(String.self, forKey: .imdbRating)
            self.imdbVotes = try container.decode(String.self, forKey: .imdbVotes)
            self.dvd = try container.decode(String.self, forKey: .DVD)
            self.boxOffice = try container.decode(String.self, forKey: .BoxOffice)
            self.production = try container.decode(String.self, forKey: .Production)
            self.website = try container.decode(String.self, forKey: .Website)
        } catch let error {
            print(error)
        }
    }
}
