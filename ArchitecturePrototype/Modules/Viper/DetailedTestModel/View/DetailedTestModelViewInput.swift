//
//  DetailedTestModelViewInput.swift
//

protocol DetailedTestModelViewInput: AnyObject {
    /**
        Updates view
    */
    func update(with updates: [DetailedTestModelViewModel.Updates])
}
