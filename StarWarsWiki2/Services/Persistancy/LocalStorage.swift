import Foundation

protocol LocalStorage: AnyObject {
    var favorites: [MainScreenCellModel] { get set }
}

final class LocalStorageImpl: LocalStorage {

    // MARK: - Public Properties
    
    var favorites: [MainScreenCellModel] {
        get {
            if let favoritesData = userDefaults.data(forKey: Keys.keyFavorites.rawValue) {
                let decoder = JSONDecoder()
                if let favoritesArray = try? decoder.decode(Array<MainScreenCellModel>.self, from: favoritesData) {
                    return favoritesArray
                } else { return [] }
            } else { return [] }
        }
        
        set {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(newValue) {
                userDefaults.set(encoded, forKey: Keys.keyFavorites.rawValue)
            }
        }
    }

    // MARK: - Private Properties
    
    private let userDefaults: UserDefaults

    private enum Keys: String {
        case keyFavorites = "KEY_FAVORITES"
    }

    // MARK: - Init

    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
}
