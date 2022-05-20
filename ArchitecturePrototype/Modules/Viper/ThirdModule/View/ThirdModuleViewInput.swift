//
//  ThirdModuleViewInput.swift
//

import SectionDataSource

protocol ThirdModuleViewInput: AnyObject {
    /**
        Updates view
    */
    func update(with updates: [ThirdModuleViewModel.Updates])

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
