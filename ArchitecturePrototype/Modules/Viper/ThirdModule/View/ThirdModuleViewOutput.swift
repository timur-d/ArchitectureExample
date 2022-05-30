//
//  ThirdModuleViewOutput.swift
//

import ReactiveSwift
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
    func itemsInSection(_ section: Int) -> [TestModel]

    func itemAtIndexPath(_ path: IndexPath) -> TestModel

    func indexPath(for item: TestModel) -> IndexPath?

    func numberOfItemsInSection(_ section: Int) -> Int

    func numberOfSections() -> Int

    func sectionIdForSection(_ section: Int) -> String

    // Action's
    var onItemSelectedAction: Action<Int, Void, Never> { get }

    var clearDatabaseAction: Action<Void, Void, Never> { get }

    var fillDatabaseAction: Action<Void, Void, Never> { get }
}
