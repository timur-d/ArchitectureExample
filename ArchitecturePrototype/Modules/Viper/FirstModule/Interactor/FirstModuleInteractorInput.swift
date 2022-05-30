//
//  FirstModuleInteractorInput.swift
//
import ReactiveSwift
import Foundation


protocol FirstModuleInteractorInput {
    func fetchCollectionsModel(byId id: Int) -> SignalProducer<TestCollectionsModel?, Never>

    func updateCollectionsModel(byId id: Int) -> SignalProducer<TestCollectionsModel?, Never>
}
