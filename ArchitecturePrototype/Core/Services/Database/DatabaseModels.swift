//
// Created by Mikhail Mulyar on 19.05.2022.
//

import Foundation
import RealmSwift
import DatabaseObjectsMapper

func testFunc() {
    let service = RealmService()

    let model = TestModel(id: 90, string: "5", model: nil)
}

public struct TestModel: AutoDatabaseMappable, Equatable {
    let id: Int
    let string: String

    let model: TestCollectionsModel?
    let models = Relation<TestCollectionsModel>(type: .direct)
}

extension TestModel: UniquelyMappable {
    public typealias Container = TestModelContainer
    public static var idKey = \TestModel.id
}

struct TestCollectionsModel: AutoDatabaseMappable, Equatable {
    let id: Int
    let strings: [String]
    let intValues: [Int64?]
    let doubleValues: [Double]?
    let dates: [Date]?
    let codable: [SomeCodable]
    let persistable: [SomePersistable]
    let urls: Array<URL>
    let dict: [String: SomePersistable]
    let anotherDict: [SomeCodable: SomeStringEnum]
    let set: Set<URL>
    let anotherSet: Set<SomeCodable?>
    let someEnum: [SomeEnum]
    let someList: [String]
    let codableEnums: [Link]
}


extension TestCollectionsModel: UniquelyMappable {
    typealias Container = TestCollectionsModelContainer
    static var idKey = \TestCollectionsModel.id
}


extension URL: FailableCustomPersistable {
    public typealias PersistedType = String

    public init?(persistedValue: String) {
        self.init(string: persistedValue)
    }

    public var persistableValue: PersistedType {
        self.absoluteString
    }
}


struct SomeCodable: Codable, Equatable, Hashable {
    let key: String
    let index: Int
}


struct SomePersistable: DictionaryCodable, Equatable, Hashable, CustomPersistable {
    let index: Int

    public typealias PersistedType = Int

    public init(persistedValue: Int) {
        self.index = persistedValue
    }

    public var persistableValue: PersistedType {
        self.index
    }
}


enum Link: Hashable, Codable {
    case chat(Int64)
    case program(Int64)
    case profile(Int64)

    public var chatId: Int64? {
        switch self {
        case .chat(let id): return id
        default: return nil
        }
    }
    public var programId: Int64? {
        switch self {
        case .program(let id): return id
        default: return nil
        }
    }
    public var profileId: Int64? {
        switch self {
        case .profile(let id): return id
        default: return nil
        }
    }
}


enum SomeEnum: Int, Codable, PersistableEnum {
    case firstCase
    case secondCase
    case thirdCase
}


enum SomeStringEnum: String, Codable {
    case firstCase
    case secondCase
    case thirdCase
}
