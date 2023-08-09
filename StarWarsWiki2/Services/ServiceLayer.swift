import Foundation

final class ServiceLayer {

    // MARK: - Public Properties

    static var shared = ServiceLayer()

    var localStorage: LocalStorage = LocalStorageImpl()
    var apiManager: APIManager = APIManager()

    // MARK: - Init

    private init() {}
    
}
