//
//  SecondModuleViewInput.swift
//

import SectionDataSource

protocol SecondModuleViewInput: AnyObject {
    /**
        Updates view
    */
    func update(with updates: [SecondModuleViewModel.Updates])

    /**
        Notifies view about data source updates
    */
    func contentDidUpdate(updates: DataSourceUpdates)

    /**
        Notifies view about search data source updates
    */
    func searchContentDidUpdate(updates: DataSourceUpdates)

    /**
        Notifies view if data source in search mode or not
    */
    func didUpdateSearchState(isSearching: Bool)
}
