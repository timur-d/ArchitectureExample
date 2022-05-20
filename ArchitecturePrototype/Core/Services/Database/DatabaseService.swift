import RealmSwift
import Foundation


public protocol DatabaseServiceProtocol {
}


// sourcery: AutoInjectableServiceProtocol=DatabaseServiceProtocol
public class DatabaseService: DatabaseServiceProtocol, AutoInjectableService {

    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}


public protocol NetworkServiceProtocol {
}


public class NetworkService: NetworkServiceProtocol, AutoInjectableService {
    init() {
    }
}