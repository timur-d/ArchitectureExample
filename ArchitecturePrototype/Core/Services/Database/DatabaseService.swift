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

    func fetchObserveAndUpdateTestModel(byId id: Int) -> SignalProducer<TestModel?, Never>

    func updateTestCollectionsModel(byId id: Int) -> SignalProducer<TestCollectionsModel?, Never>

    func fetchTestCollectionsModel(byId id: Int) -> SignalProducer<TestCollectionsModel?, Never>
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

    public func fetchObserveAndUpdateTestModel(byId id: Int) -> SignalProducer<TestModel?, Never> {
        .init { [weak self] observer, lifetime in
            guard let self = self else { return observer.sendCompleted() }

            lifetime += self.networkService.loadTestModelFromServer(byId: id)
                .startWithValues { [weak self] model in
                    guard let self = self else { return observer.sendCompleted() }
                    #warning("deleted state not handled")
                    guard let model = model else { return }

                    self.db.save(model: model)
                }

            let token = self.db.fetch({ $0.id == id }, limit: 1, callback: { (models: [TestModel]) in
                observer.send(value: models.first)
            }, updates: {updates in
                observer.send(value: updates.values.first)
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

    public func updateTestCollectionsModel(byId id: Int) -> SignalProducer<TestCollectionsModel?, Never> {
        self.networkService.loadTestCollectionsModelFromServer(byId: id)
            .on(value: { [weak self] model in
                guard let self = self, let model = model else { return }
#warning("Conversion from  Protobuf > Db required here")
#warning("DbService not good place to make a network request")
                self.db.save(model: model)
            })
    }

    public func fetchTestCollectionsModel(byId id: Int) -> SignalProducer<TestCollectionsModel?, Never> {
        .init { [weak self] observer, _ in
            guard let self = self else { return observer.sendCompleted() }

            let model: TestCollectionsModel? = self.db.syncFetchUnique(with: id)
            observer.send(value: model)
            observer.sendCompleted()
        }
    }
}


public protocol NetworkServiceProtocol {
    func loadTestModelFromServer(byId id: Int) -> SignalProducer<TestModel?, Never>
    func loadTestModelsFromServer() -> SignalProducer<[TestModel], Never>
    func loadTestCollectionsModelFromServer(byId id: Int) -> SignalProducer<TestCollectionsModel?, Never>
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

    public func loadTestModelFromServer(byId id: Int) -> SignalProducer<TestModel?, Never> {
        let firstArray = ["Some", "Any", "One", "Two"]
        let secondArray = ["Green", "Red", "Blue", "Orange"]
        let thirdArray = ["Apple", "Tomato", "Orange", "Banana"]

        return .init(value: TestModel(id: id,
                                      string: [firstArray.randomElement(),
                                               secondArray.randomElement(),
                                               thirdArray.randomElement(),
                                               "\(id)", "nwCreated"].lazy
            .compactMap { $0 }
            .joined(separator: " "),
                                      model: nil))
        .delay(15.0, on: QueueScheduler.main)
    }

    public func loadTestCollectionsModelFromServer(byId id: Int) -> SignalProducer<TestCollectionsModel?, Never> {
        let firstArray = ["Some", "Any", "One", "Two"]
        let secondArray = ["Green", "Red", "Blue", "Orange"]
        let thirdArray = ["Apple", "Tomato", "Orange", "Banana"]

        return SignalProducer { observer, _ in
            if id == 404 {
                observer.send(value: nil)
                observer.sendCompleted()
                return
            }

            let randomStrings = (0..<((10...100).randomElement() ?? 10)).map {
                ["\($0)", firstArray.randomElement(), secondArray.randomElement(), thirdArray.randomElement()]
                    .lazy
                    .compactMap { $0 }
                    .joined(separator: " ")
            }
            let random2Strings = (0..<((10...100).randomElement() ?? 10)).map {
                ["\($0)", firstArray.randomElement(), secondArray.randomElement(), thirdArray.randomElement()]
                    .lazy
                    .compactMap { $0 }
                    .joined(separator: " ")
            }
            let intValues: [Int64] = (0..<((10...100).randomElement() ?? 10))
                .lazy
                .map { (10...1000).randomElement() ?? $0 }
                .map { Int64($0) }

            let dateValues: [Date] = (0..<((10...100).randomElement() ?? 10))
                .lazy
                .compactMap { (10...1000).randomElement() ?? $0 }
                .map { Double($0) }
                .map { Date.init(timeIntervalSince1970: Date().timeIntervalSince1970 + $0) }

            observer.send(value: .init(id: id,
                                       strings: randomStrings,
                                       intValues: intValues,
                                       doubleValues: nil,
                                       dates: dateValues,
                                       codable: [],
                                       persistable: [],
                                       urls: [],
                                       dict: [:],
                                       anotherDict: [:],
                                       set: [],
                                       anotherSet: [],
                                       someEnum: [],
                                       someList: random2Strings,
                                       codableEnums: []))
            observer.sendCompleted()
        }
        .delay(5.0, on: QueueScheduler.main)
    }
}
