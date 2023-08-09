// 
//  APIManager.swift
//  StarWarsWiki2
//
//  Created by Иван Гришин on 07.08.2023.
//

import UIKit
import Alamofire

final class APIManager {
    
    // MARK: - Constants
    
    private enum Constants {
        static let apiLink = "https://swapi.dev/api/"
        static let search = "?search="
        static let people = "people/"
        static let starships = "starships/"
        static let planets = "planets/"
    }
    
    // MARK: - Type
    
    private enum LinkTypes {
        case characterSearch
        case starshipsSearch
        case planetsSearch
    }
    
    // MARK: - Public Methods
    
    func searchPlanets(searchText: String, completion: @escaping (PlanetsResult) -> Void) {
        AF.request(
            getFullLink(for: .planetsSearch) + searchText,
            method: .get,
            encoding: JSONEncoding.default
        ).responseDecodable(of: PlanetsResult.self) { response in
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func searchStarships(searchText: String, completion: @escaping (StarshipsResult) -> Void) {
        AF.request(
            getFullLink(for: .starshipsSearch) + searchText,
            method: .get,
            encoding: JSONEncoding.default
        ).responseDecodable(of: StarshipsResult.self) { response in
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func searchCharacter(searchText: String, completion: @escaping (CharactersResult) -> Void) {
        AF.request(
            getFullLink(for: .characterSearch) + searchText,
            method: .get,
            encoding: JSONEncoding.default
        ).responseDecodable(of: CharactersResult.self) { response in
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func getFullLink(for type: LinkTypes) -> String {
        switch type {
        case .characterSearch:
            return Constants.apiLink + Constants.people + Constants.search
        case .starshipsSearch:
            return Constants.apiLink + Constants.starships + Constants.search
        case .planetsSearch:
            return Constants.apiLink + Constants.planets + Constants.search
        }
    }
}
