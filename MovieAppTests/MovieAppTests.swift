//
//  MovieAppTests.swift
//  MovieAppTests
//
//  Created by Riajur Rahman on 22/2/21.
//

import XCTest
@testable import MovieApp

class MovieAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchMovieAPI() {
        let moviesExpectation = expectation(description: "movies")
        var moviesResponse: [Movie]?
        Service.shared.loadMovies(queryParams: "s=Marvel&type=movie") { (movies, totalResults, error) in
            moviesResponse = movies
            if error == nil {
                moviesExpectation.fulfill()
            }
        }
        self.waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(moviesResponse)
        }
    }

    func testWebsiteKeyInMovieDetails() {
        let keyExpectation = expectation(description: "website")
        var movieDetails: MovieInfo?
        let queryString = String(format: "i=%@", "tt4154664")
        Service.shared.loadMovieDetails(queryParams: queryString) { (movieInfo, error) in
            movieDetails = movieInfo
            if movieDetails?.website == "N/A" {
                keyExpectation.fulfill()
            }
        }
        self.waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(movieDetails)
        }
    }
}
