//
//  DetailedTestModelViewOutput.swift
//


protocol DetailedTestModelViewOutput {

    /**
        Notify presenter that view is ready
    */
    func viewIsReady()

    /**
        View model. Current state
    */
    var model: DetailedTestModelViewModel { get }

    /**
        View updates model from user interactions. Use notify=true carefully to avoid loop.
    */
    func update(with updates: [DetailedTestModelViewModel.Updates], notify: Bool)

}
