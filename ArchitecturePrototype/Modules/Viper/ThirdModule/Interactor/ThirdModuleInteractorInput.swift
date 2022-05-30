//
//  ThirdModuleInteractorInput.swift
//

import ReactiveSwift
import Foundation


protocol ThirdModuleInteractorInput {
    func clearDatabase()

    func fillDatabase()

    func fetchAndObserveModels() -> SignalProducer<[TestModel], Never>
}
