//
//  FirstModuleViewOutput.swift
//

protocol FirstModuleViewOutput {

    /**
        Notify presenter that view is ready
    */
    func viewIsReady()

    /**
        View model. Current state
    */
    var model: FirstModuleViewModel { get }

    /**
        View updates model from user interactions. Use notify=true carefully to avoid loop.
    */
    func update(with updates: [FirstModuleViewModel.Updates], notify: Bool)
}
