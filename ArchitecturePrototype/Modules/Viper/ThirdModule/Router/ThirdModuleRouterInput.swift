//
//  ThirdModuleRouterInput.swift
//

import Foundation

// typealias AnyThirdModuleContext = ThirdModuleContext
public protocol AnyThirdModuleContext: AnyObject {

}

public protocol ThirdModuleRouterInput: AnyObject {
    func showTestModel(withId id: Int)
}
