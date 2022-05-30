//
//  ThirdModulePresenter.swift
//

import SectionDataSource
import ReactiveSwift


final class ThirdModulePresenter {
    // lifetime
    private let (lifetime, token) = Lifetime.make()

    // Links
    private(set) var interactor: ThirdModuleInteractorInput
    private(set) weak var router: ThirdModuleRouterInput!
    weak var context: AnyThirdModuleContext!
    weak var viewInput: ThirdModuleViewInput!

    // State model
    private(set) var model: ThirdModuleViewModel

    // Data Source
    private let dataSource: SimpleDataSource<TestModel>

    // Action's
    private(set) lazy var onItemSelectedAction: Action<Int, Void, Never> = .init {
        [unowned self] id in

        self.router.showTestModel(withId: id)

        return .empty
    }

    private(set) lazy var clearDatabaseAction: Action<Void, Void, Never> = .init {
        [unowned self] in

        self.interactor.clearDatabase()

        // reuse will be available after 3 seconds 
        return SignalProducer.empty.delay(3.0, on: QueueScheduler.main)
    }

    private(set) lazy var fillDatabaseAction: Action<Void, Void, Never> = .init {
        [unowned self] in

        self.interactor.fillDatabase()

        return .empty
    }

    // Init's
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
    func viewIsReady() {
        self.lifetime += self.interactor
            .fetchAndObserveModels()
            .startWithValues { [weak self] models in
                self?.dataSource.update(items: models)
            }
    }
    func update(with updates: [ThirdModuleViewModel.Updates], notify: Bool = false) {
        self.model = self.model.updated(updates)

        if notify {
            self.viewInput.update(with: updates)
        }
    }

    func itemsInSection(_ section: Int) -> [TestModel] {
        self.dataSource.itemsInSection(section)
    }

    func itemAtIndexPath(_ path: IndexPath) -> TestModel {
        self.dataSource.itemAtIndexPath(path)
    }

    func indexPath(for item: TestModel) -> IndexPath? {
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
