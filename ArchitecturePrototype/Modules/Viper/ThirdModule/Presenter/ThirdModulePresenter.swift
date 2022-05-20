//
//  ThirdModulePresenter.swift
//

import SectionDataSource


final class ThirdModulePresenter {

    private(set) var interactor: ThirdModuleInteractorInput
    private(set) weak var router: ThirdModuleRouterInput!
    weak var context: AnyThirdModuleContext!
    weak var viewInput: ThirdModuleViewInput!

    private(set) var model: ThirdModuleViewModel


    private let dataSource: SimpleDataSource<TestCollectionsModel>
    init(interactor: ThirdModuleInteractorInput, router: ThirdModuleRouterInput) {
        self.interactor = interactor
        self.router = router

        let modelValue = ThirdModuleViewModel.initial
        self.model = modelValue


        self.dataSource = SimpleDataSource(sortType: .unsorted)
        self.dataSource.delegate = self
    }
}


extension ThirdModulePresenter: ThirdModuleModuleInput {

}


extension ThirdModulePresenter: ThirdModuleViewOutput {
    func viewIsReady() {}
    func update(with updates: [ThirdModuleViewModel.Updates], notify: Bool = false) {
        self.model = self.model.updated(updates)

        if notify {
            self.viewInput.update(with: updates)
        }
    }

    func itemsInSection(_ section: Int) -> [TestCollectionsModel] {
        self.dataSource.itemsInSection(section)
    }

    func itemAtIndexPath(_ path: IndexPath) -> TestCollectionsModel {
        self.dataSource.itemAtIndexPath(path)
    }

    func indexPath(for item: TestCollectionsModel) -> IndexPath? {
        self.dataSource.indexPath(for: item)
    }

    func numberOfItemsInSection(_ section: Int) -> Int {
        self.dataSource.numberOfItemsInSection(section)
    }

    func numberOfSections() -> Int {
        self.dataSource.numberOfSections()
    }

    func sectionIdForSection(_ section: Int) -> String {
        self.dataSource.sectionIdForSection(section)
    }
}


extension ThirdModulePresenter: ThirdModuleInteractorOutput {}


extension ThirdModulePresenter: SectionDataSourceDelegate {
    func dataSource<T>(_ dataSource: SectionDataSource<T>, didUpdateContent updates: DataSourceUpdates, operationIndex: OperationIndex) {
        self.viewInput?.contentDidUpdate(updates: updates)
    }

    func dataSource<T>(_ dataSource: SectionDataSource<T>, didUpdateSearchContent updates: DataSourceUpdates) {
        self.viewInput?.searchContentDidUpdate(updates: updates)
    }

    func dataSource<T>(_ dataSource: SectionDataSource<T>, didUpdateSearchState isSearching: Bool) {
        self.viewInput?.didUpdateSearchState(isSearching: isSearching)
    }
}
