//
//  ThirdModuleViewOutput.swift
//

import UIKit

protocol ThirdModuleViewOutput {

    /**
        Notify presenter that view is ready
    */
    func viewIsReady()

    /**
        View model. Current state
    */
    var model: ThirdModuleViewModel { get }

    /**
        View updates model from user interactions. Use notify=true carefully to avoid loop.
    */
    func update(with updates: [ThirdModuleViewModel.Updates], notify: Bool)


    /**
        DataSource methods
    */
    func itemsInSection(_ section: Int) -> [TestCollectionsModel]

    func itemAtIndexPath(_ path: IndexPath) -> TestCollectionsModel

    func indexPath(for item: TestCollectionsModel) -> IndexPath?

    func numberOfItemsInSection(_ section: Int) -> Int

    func numberOfSections() -> Int

    func sectionIdForSection(_ section: Int) -> String
}
