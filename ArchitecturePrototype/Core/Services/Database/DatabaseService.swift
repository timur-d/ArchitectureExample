import DatabaseObjectsMapper
import ReactiveSwift
import Foundation
import RealmSwift

public protocol DatabaseServiceProtocol {
    var db: RealmService { get }

    func fillDatabaseWithTestModels()

    func clearAllDatabase()

    func fetchAndObserveTestModels() -> SignalProducer<[TestModel], Never>

    func fetchAndObserveNetworkModels() -> SignalProducer<[TestModel], Never>

    func updateTestModels() -> SignalProducer<[TestModel], Never>
}


// sourcery: AutoInjectableServiceProtocol=DatabaseServiceProtocol
public class DatabaseService: DatabaseServiceProtocol, AutoInjectableService {

    public let db = RealmService()
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService

        DatabaseSetup.setupDatabase()
    }

    public func fillDatabaseWithTestModels() {
        let firstArray = ["Some", "Any", "One", "Two"]
        let secondArray = ["Green", "Red", "Blue", "Orange"]
        let thirdArray = ["Apple", "Tomato", "Orange", "Banana"]
        self.db.save(models: (0..<100).map {
            TestModel(id: 20 + $0,
                      string: [firstArray.randomElement(),
                               secondArray.randomElement(),
                               thirdArray.randomElement(),
                               "dbCreated"].lazy
                .compactMap { $0 }
                .joined(separator: " "),
                      model: nil)
        })
    }

    public func clearAllDatabase() {
        self.db.deleteAll()
    }

    public func fetchAndObserveTestModels() -> SignalProducer<[TestModel], Never> {
        .init { [weak self] observer, lifetime in
            guard let self = self else { return observer.sendCompleted() }

            let token = self.db.fetch(callback: { (models: [TestModel]) in
                observer.send(value: models)
            }, updates: { updates in
                observer.send(value: updates.values)
            })

            lifetime.observeEnded {
                token.invalidate()
            }
        }
    }

    public func fetchAndObserveNetworkModels() -> SignalProducer<[TestModel], Never> {
        .init { [weak self] observer, lifetime in
            guard let self = self else { return observer.sendCompleted() }

            let token = self.db.fetch({ $0.string.ends(with: "nwCreated") }, callback: { (models: [TestModel]) in
                observer.send(value: models)
            }, updates: {updates in
                observer.send(value: updates.values)
            })

            lifetime.observeEnded {
                token.invalidate()
            }
        }
    }

    public func updateTestModels() -> SignalProducer<[TestModel], Never> {
        self.networkService.loadTestModelsFromServer()
            .on(value: { [weak self] models in
                guard let self = self else { return }
                #warning("Conversion from  Protobuf > Db required here")
                #warning("DbService not good place to make a network request")
                self.db.save(models: models)
            })
    }
}


public protocol NetworkServiceProtocol {
    func loadTestModelsFromServer() -> SignalProducer<[TestModel], Never>
}


// sourcery: AutoInjectableServiceProtocol=NetworkServiceProtocol
public class NetworkService: NetworkServiceProtocol, AutoInjectableService {
    init() {}

    #warning("No error imitated like a network request")
    public func loadTestModelsFromServer() -> SignalProducer<[TestModel], Never> {
        let firstArray = ["Some", "Any", "One", "Two"]
        let secondArray = ["Green", "Red", "Blue", "Orange"]
        let thirdArray = ["Apple", "Tomato", "Orange", "Banana"]

        return .init(value: (0..<30).map {
            TestModel(id: $0,
                      string: [firstArray.randomElement(),
                               secondArray.randomElement(),
                               thirdArray.randomElement(),
                               "\($0)", "nwCreated"].lazy
                .compactMap { $0 }
                .joined(separator: " "),
                      model: nil)
        })
        .delay(15.0, on: QueueScheduler.main)
    }
}
