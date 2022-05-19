//
//  NetworkService.swift
//  multi-sport-app
//
//  Created by Vincent Tran on 15/5/2022.
//

import Foundation

struct NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    func fetchTeams(completion: @escaping(Result<[Team], Error>) -> Void) {
        request(api: .nbaApi, route: .allTeams, method: .get, completion: completion)
    }
    
    func fetchPlayers(team: String, season: String, completion: @escaping(Result<[Player], Error>) -> Void) {
        request(api: .nbaApi, route: .allPlayers, method: .get, parameters: ["team": team, "season": season], completion: completion)
    }
    
    func fetchArticles(query: String, completion: @escaping(Result<[Article], Error>) -> Void) {
        request(api: .newsApi, route: .allArticles, method: .get, parameters: ["q": query], completion: completion)
    }
    
    func fetchGames(date: String, completion: @escaping(Result<[Game], Error>) -> Void) {
        request(api: .nbaApi , route: .allGames, method: .get, parameters: ["date": date], completion: completion)
    }
    
    private func request<T: Decodable>(api: Api, route: Route,
                                       method: Method,
                                       parameters: [String: Any]? = nil,
                                       completion: @escaping(Result<T, Error>) -> Void) {
        guard let request = createRequest(api: api, route: route, method: method, parameters: parameters) else {
            completion(.failure(AppError.unknownError))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            var result: Result<Data, Error>?
            if let data = data {
                result = .success(data)
                let responseString = String(data: data, encoding: .utf8) ?? "Could not turn data into string"
                print("The response is:\n\(responseString)")
            } else if let error = error {
                result = .failure(error)
                print("The error is: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                switch api {
                case .nbaApi:
                    rapidResponse(result: result, completion: completion)
                case .newsApi:
                    newsResponse(result: result, completion: completion)
                }
            }
        }.resume()
    }
    
    private func rapidResponse<T: Decodable>(result: Result<Data, Error>?,
                               completion: (Result<T, Error>) -> Void) {
        guard let result = result else {
            completion(.failure(AppError.unknownError))
            return
        }
        
        switch result {
        case .success(let data):
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(RapidResponse<T>.self, from: data) else {
                completion(.failure(AppError.errorDecoding))
                return
            }
            
            // TODO Fix error handling for server errors[] response
            if let errors = response.errors {
                if errors.count >= 1 {
                    completion(.failure(AppError.serverError))
                    return
                }
            }
            
            
            if let decodedData = response.response {
                completion(.success(decodedData))
            } else {
                completion(.failure(AppError.noData))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    private func newsResponse<T: Decodable>(result: Result<Data, Error>?,
                               completion: (Result<T, Error>) -> Void) {
        guard let result = result else {
            completion(.failure(AppError.unknownError))
            return
        }
        
        switch result {
        case .success(let data):
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(NewsResponse<T>.self, from: data) else {
                completion(.failure(AppError.errorDecoding))
                return
            }
            if let decodedData = response.articles {
                completion(.success(decodedData))
            } else {
                completion(.failure(AppError.noData))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    /// This function helps us to generate a urlRequest
    /// - Parameters:
    ///   - route: the path to the resource in the backend
    ///   - method: the type of request to be made
    ///   - parameters: whatever extra information you need to pass to the backend
    /// - Returns: URLRequest
    private func createRequest(api: Api, route: Route,
                               method: Method,
                               parameters: [String: Any]? = nil) -> URLRequest? {
        let urlString = api.baseUrl + route.description
        guard let url = URL(string: urlString) else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = api.headers
        urlRequest.httpMethod = method.rawValue
        
        if let params = parameters {
            switch method {
            case .get:
                var urlComponent = URLComponents(string: urlString)
                urlComponent?.queryItems = params.map { URLQueryItem(name: $0, value: "\($1)") }
                urlRequest.url = urlComponent?.url
            case .post, .delete, .patch:
                let bodyData = try? JSONSerialization.data(withJSONObject: params, options: [])
                urlRequest.httpBody = bodyData
            }
        }
        return urlRequest
    }
}
