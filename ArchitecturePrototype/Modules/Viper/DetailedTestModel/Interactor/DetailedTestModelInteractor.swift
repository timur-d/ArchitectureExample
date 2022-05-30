//
//  DetailedTestModelInteractor.swift
//

import ReactiveSwift
import Foundation


final class DetailedTestModelInteractor: DetailedTestModelInteractorInput {
    weak var output: DetailedTestModelInteractorOutput!

    let databaseService: DatabaseServiceProtocol
    let networkService: NetworkServiceProtocol

    init(databaseService: DatabaseServiceProtocol,
         networkService: NetworkServiceProtocol) {
        self.databaseService = databaseService
        self.networkService = networkService
    }

    func getTestModel(byId id: Int) -> SignalProducer<TestModel?, Never> {
        self.databaseService.fetchObserveAndUpdateTestModel(byId: id)
    }
}
