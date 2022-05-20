//
//  FirstModuleRouterInput.swift
//

import Foundation


// typealias AnyFirstModuleContext = FirstModuleContext
public protocol AnyFirstModuleContext: AnyObject {}


public protocol FirstModuleRouterInput: AnyObject {
    func didTapInfo()
}
