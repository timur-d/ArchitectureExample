//
//  SecondModuleViewOutput.swift
//

import UIKit

protocol SecondModuleViewOutput {

    /**
        Notify presenter that view is ready
    */
    func viewIsReady()

    /**
        View model. Current state
    */
    var model: SecondModuleViewModel { get }

    /**
        View updates model from user interactions. Use notify=true carefully to avoid loop.
    */
    func update(with updates: [SecondModuleViewModel.Updates], notify: Bool)


    /**
        DataSource methods
    */
    func itemsInSection(_ section: Int) -> [TestModel]

    func itemAtIndexPath(_ path: IndexPath) -> TestModel

    func indexPath(for item: TestModel) -> IndexPath?

    func numberOfItemsInSection(_ section: Int) -> Int

    func numberOfSections() -> Int

    func sectionIdForSection(_ section: Int) -> String
}
