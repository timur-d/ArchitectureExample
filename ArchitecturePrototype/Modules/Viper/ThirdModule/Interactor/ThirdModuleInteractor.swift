//
//  ThirdModuleInteractor.swift
//

import ReactiveSwift
import Foundation


final class ThirdModuleInteractor: ThirdModuleInteractorInput {
    weak var output: ThirdModuleInteractorOutput!

    private let networkService: NetworkServiceProtocol
    private let databaseService: DatabaseServiceProtocol

    init(networkService: NetworkServiceProtocol,
         databaseService: DatabaseServiceProtocol) {
        self.networkService = networkService
        self.databaseService = databaseService
    }

    func clearDatabase() {
        self.databaseService.clearAllDatabase()
    }

    func fillDatabase() {
        self.databaseService.fillDatabaseWithTestModels()
    }


    func fetchAndObserveModels() -> SignalProducer<[TestModel], Never> {
        // just start update process
        databaseService.updateTestModels().start()

        return databaseService.fetchAndObserveTestModels()
    }
}
