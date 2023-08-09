// 
//  MainScreenModel.swift
//  StarWarsWiki2
//
//  Created by Иван Гришин on 08.08.2023.
//

import UIKit

/// Модель для отображения в ячейке
struct MainScreenCellModel: Codable, Equatable {
    let title: String
    let firstSubtitle: String
    let secondSubtitle: String
    let thirdSubtitle: String?
    let type: ModelType
    
    // Character init
    init(model: CharactersModel) {
        self.title = "name: \(model.name)"
        self.firstSubtitle = "gender: \(model.gender)"
        self.secondSubtitle = "starships count: \(model.starships.count)"
        self.thirdSubtitle = nil
        self.type = .characters
    }
    
    // Starships init
    init(model: StarshipsModel) {
        self.title = "name: \(model.name)"
        self.firstSubtitle = "model: \(model.model)"
        self.secondSubtitle = "manufacturer: \(model.manufacturer)"
        self.thirdSubtitle = "passengers count: \(model.passengers)"
        self.type = .starships
    }
    
    // Planets init
    init(model: PlanetsModel) {
        self.title = "name: \(model.name)"
        self.firstSubtitle = "diameter: \(model.diameter)"
        self.secondSubtitle = "population: \(model.population)"
        self.thirdSubtitle = nil
        self.type = .planets
    }
}

protocol MainScreenModelProtocol: AnyObject {
    /// Выбранный тип для модели
    var selectedModelType: ModelType { get set }
    /// Массив отображаемых ячеек
    var items: [MainScreenCellModel] { get set }
    
    /// Обновить модель по текстовому запросу
    func updateModel(manager: APIManager, searchText: String, completion: @escaping (() -> Void))
    /// Изменить тип модели
    func changeModel(type: ModelType)
    /// Добавить ячейку в избранное
    func addToFavorite(_ storage: LocalStorage, indexPath: IndexPath)
    /// Удалить ячейку из избранного
    func removeFromStorage(_ storage: LocalStorage, indexPath: IndexPath)
    /// Возвращает статус ячейки (true == добавлено в избранное)
    func getFavoriteStatus(_ storage: LocalStorage, indexPath: IndexPath) -> Bool
}

final class MainScreenModel: MainScreenModelProtocol {
    var selectedModelType: ModelType = .characters
    var items: [MainScreenCellModel] = []
    
    func updateModel(manager: APIManager, searchText: String, completion: @escaping () -> Void) {
        guard searchText.count >= 2 else {
            items = []
            completion()
            return
        }
        let searchText = searchText.components(separatedBy: " ").joined()
        switch selectedModelType {
        case .characters:
            manager.searchCharacter(searchText: searchText) { [weak self] characterResult in
                guard let self else { return }
                self.items = characterResult.results.map({ .init(model: $0) })
                completion()
            }
        case .starships:
            manager.searchStarships(searchText: searchText) { [weak self] starshipsResult in
                guard let self else { return }
                self.items = starshipsResult.results.map({ .init(model: $0) })
                completion()
            }
        case .planets:
            manager.searchPlanets(searchText: searchText) { [weak self] planetsResult in
                guard let self else { return }
                self.items = planetsResult.results.map({ .init(model: $0) })
                completion()
            }
        }
    }
    
    func changeModel(type: ModelType) {
        selectedModelType = type
        items = []
    }
    
    func addToFavorite(_ storage: LocalStorage, indexPath: IndexPath) {
        let item = items[indexPath.item]
        storage.favorites.append(item)
    }
    
    func removeFromStorage(_ storage: LocalStorage, indexPath: IndexPath) {
        storage.favorites.removeAll(where: { $0 == items[indexPath.item] })
    }
    
    func getFavoriteStatus(_ storage: LocalStorage, indexPath: IndexPath) -> Bool {
        return storage.favorites.contains(where: { $0 == items[indexPath.item] })
    }
}
