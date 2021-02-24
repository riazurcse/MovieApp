//
//  APIClient.swift
//  MovieApp
//
//  Created by Riajur Rahman on 22/2/21.
//

import Foundation
import Alamofire


enum EndPoints: String {
    case BASE_URL = "http://www.omdbapi.com/?apikey=%@"
}

enum Status: String {
    case True
    case False
}

class APIClient {
    
    static func get(_ url: String, completion: @escaping (([String: Any]?, Error?) -> ())) {
        AF.request(url, method: .get)
        .validate()
        .responseJSON { response in
            switch (response.result) {
            case .success(let data):
                if let value = data as? [String: Any], let _response = value["Response"] as? String {
                    if _response == Status.True.rawValue {
                        completion(value, nil)
                        return
                    } else {
                        var errorMessage: String? = nil
                        if let error = value["Error"] as? String {
                            errorMessage = error
                        }
                        CommonUtils.showPrompt("Opps...", message: errorMessage ?? Constant.GENERIC_MESSAGE , buttons: ["OK"], delegate: nil) { _ in }
                    }
                } else {
                    CommonUtils.showPrompt("Opps...", message: Constant.GENERIC_MESSAGE, buttons: ["OK"], delegate: nil) { _ in }
                }
                completion(nil, nil)
            case .failure(let error):
                completion(nil, error)
                CommonUtils.showPrompt("Opps...", message: error.localizedDescription, buttons: ["OK"], delegate: nil) { _ in }
            }
        }
    }
}
