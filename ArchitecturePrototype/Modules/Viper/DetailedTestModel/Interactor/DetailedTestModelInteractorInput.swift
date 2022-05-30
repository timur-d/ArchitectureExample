//
//  DetailedTestModelInteractorInput.swift
//
import ReactiveSwift
import Foundation


protocol DetailedTestModelInteractorInput {
    func getTestModel(byId id: Int) -> SignalProducer<TestModel?, Never>
}
