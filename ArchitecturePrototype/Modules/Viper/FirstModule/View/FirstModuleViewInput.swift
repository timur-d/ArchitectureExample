//
//  FirstModuleViewInput.swift
//

protocol FirstModuleViewInput: AnyObject {
    /**
        Updates view
    */
    func update(with updates: [FirstModuleViewModel.Updates])

    func dismissKeyboard()
}
