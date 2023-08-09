// 
//  APIModel.swift
//  StarWarsWiki2
//
//  Created by Иван Гришин on 08.08.2023.
//

import UIKit

// MARK: - Type

enum ModelType: String, CaseIterable, Codable {
    case characters = "Characters"
    case starships = "Star ships"
    case planets = "Planets"
    
    func getTypeIcon() -> UIImage? {
        switch self {
        case .characters:
            return "👩‍🎤".textToImage()
        case .starships:
            return "🚀".textToImage()
        case .planets:
            return "🪐".textToImage()
        }
    }
}

// MARK: - Character

struct CharactersResult: Codable {
    let results: [CharactersModel]
}

struct CharactersModel: Codable {
    let name: String
    let gender: String
    let starships: [String]
}

// MARK: - Starships

struct StarshipsResult: Codable {
    let results: [StarshipsModel]
}

struct StarshipsModel: Codable {
    let name: String
    let model: String
    let manufacturer: String
    let passengers: String
}

// MARK: - Planets

struct PlanetsResult: Codable {
    let results: [PlanetsModel]
}

struct PlanetsModel: Codable {
    let name: String
    let diameter: String
    let population: String
}
