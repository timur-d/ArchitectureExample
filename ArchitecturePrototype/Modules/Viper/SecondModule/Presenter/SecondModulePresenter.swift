//
//  SecondModulePresenter.swift
//

import SectionDataSource


final class SecondModulePresenter {

    private(set) var interactor: SecondModuleInteractorInput
    private(set) weak var router: SecondModuleRouterInput!
    weak var context: AnySecondModuleContext!
    weak var viewInput: SecondModuleViewInput!

    private(set) var model: SecondModuleViewModel


    private let dataSource: SimpleDataSource<TestCollectionsModel>
    init(interactor: SecondModuleInteractorInput, router: SecondModuleRouterInput) {
        self.interactor = interactor
        self.router = router

        let modelValue = SecondModuleViewModel.initial
        self.model = modelValue


        self.dataSource = SimpleDataSource(sortType: .unsorted)
        self.dataSource.delegate = self
    }
}


extension SecondModulePresenter: SecondModuleModuleInput {

}


extension SecondModulePresenter: SecondModuleViewOutput {
    func viewIsReady() {}
    func update(with updates: [SecondModuleViewModel.Updates], notify: Bool = false) {
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


extension SecondModulePresenter: SecondModuleInteractorOutput {}


extension SecondModulePresenter: SectionDataSourceDelegate {
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

extension TestCollectionsModel: Diffable {
    public var differenceIdentifier: Int {
        id
    }
}