//
//  Service.swift
//  MovieApp
//
//  Created by Riajur Rahman on 24/2/21.
//

import Foundation

class Service {
    
    static let shared = Service()
    
    func loadMovies(queryParams: String, completion: @escaping (([Movie]?, String?, Error?) -> ())) {
        guard let url = String(format: "\(EndPoints.BASE_URL.rawValue)&%@", Constant.API_KEY, queryParams).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            ProgressHUD.sharedInstance.hide()
            return
        }
        APIClient.get(url) { (responseObject, error) in
            do {
                if let response = responseObject {
                    let jsonData = try JSONSerialization.data(withJSONObject: response)
                    let rootResponse = try JSONDecoder().decode(Root.self, from: jsonData)
                    completion(rootResponse.movies, rootResponse.totalResults, nil)
                } else {
                    completion(nil, nil, error)
                }
            } catch let error {
                completion(nil, nil, error)
            }
        }
    }
    
    func loadMovieDetails(queryParams: String, completion: @escaping ((MovieInfo?, Error?) -> ())) {
        guard let url = String(format: "\(EndPoints.BASE_URL.rawValue)&%@", Constant.API_KEY, queryParams).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            ProgressHUD.sharedInstance.hide()
            return
        }
        APIClient.get(url) { (responseObject, error) in
            do {
                if let response = responseObject {
                    let jsonData = try JSONSerialization.data(withJSONObject: response)
                    let movieInfo = try JSONDecoder().decode(MovieInfo.self, from: jsonData)
                    completion(movieInfo, nil)
                } else {
                    completion(nil, error)
                }
            } catch let error {
                completion(nil, error)
            }
        }
    }
}
