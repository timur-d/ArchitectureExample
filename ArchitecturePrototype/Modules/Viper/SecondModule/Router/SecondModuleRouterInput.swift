//
//  SecondModuleRouterInput.swift
//

import Foundation

// typealias AnySecondModuleContext = SecondModuleContext
public protocol AnySecondModuleContext: AnyObject {

}

public protocol SecondModuleRouterInput: AnyObject {
    func showTestModel(withId id: Int)
}
