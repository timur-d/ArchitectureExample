//
//  FirstModuleInteractor.swift
//

import ReactiveSwift
import Foundation


final class FirstModuleInteractor: FirstModuleInteractorInput {
    weak var output: FirstModuleInteractorOutput!

    private let networkService: NetworkServiceProtocol
    private let databaseService: DatabaseServiceProtocol

    init(networkService: NetworkServiceProtocol,
         databaseService: DatabaseServiceProtocol) {
        self.networkService = networkService
        self.databaseService = databaseService
    }

    func fetchCollectionsModel(byId id: Int) -> SignalProducer<TestCollectionsModel?, Never> {
        databaseService.fetchTestCollectionsModel(byId: id)
    }

    func updateCollectionsModel(byId id: Int) -> SignalProducer<TestCollectionsModel?, Never> {
        databaseService.updateTestCollectionsModel(byId: id)
    }
}
