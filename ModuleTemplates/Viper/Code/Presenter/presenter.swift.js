<%_ 
fileName = `${moduleName}Presenter`
let interactorName = `${moduleName}Interactor`
let routerName = `${moduleName}Router`
let presenterName = `${moduleName}Presenter`
let viewModelName = `${moduleName}ViewModel`
let useDataSource = dataSourceItemName
-%><%- include("../../fileCommonHeader.ejs"); %>

<% if (useDataSource) { -%>
import SectionDataSource
<% } -%>


final class <%= presenterName %> {

    private(set) var interactor: <%= interactorName %>Input
    <%_ if (useCoordinator) { -%>
    private(set) weak var router: <%= routerName %>Input!
    weak var context: Any<%= moduleName %>Context!
    weak var viewInput: <%= moduleName %>ViewInput!
    <%_ } else { -%>
    private(set) var router: <%= routerName %>Input
    var viewInput: <%= moduleName %>ViewInput! {
        self.router.viewInput
    }
    <%_ } -%><% if (useViewModel) {%>
    private(set) var model: <%= viewModelName %>

    <%_ } -%><% if (useDataSource) { %>
    private let dataSource: SimpleDataSource<<%=dataSourceItemName%>>
    <%_ } -%>
    init(interactor: <%=moduleName%>InteractorInput, router: <%=moduleName%>RouterInput) {
        self.interactor = interactor
        self.router = router
        <%_ if (useViewModel) { -%>

        let modelValue = <%=moduleName%>ViewModel.initial
        self.model = modelValue
        <%_ } -%><% if (useDataSource) { %>

        self.dataSource = SimpleDataSource(sortType: .unsorted)
        self.dataSource.delegate = self
        <%_ } -%>
    }
}


extension <%=presenterName%>: <%=moduleName%>ModuleInput {

}


extension <%=presenterName%>: <%=moduleName%>ViewOutput {
    func viewIsReady() {}
    <%_ if (useViewModel) { -%>
    func update(with updates: [<%=moduleName%>ViewModel.Updates], notify: Bool = false) {
        self.model = self.model.updated(updates)

        if notify {
            self.viewInput.update(with: updates)
        }
    }
    <%_ } -%><% if (useDataSource) { %>
    func itemsInSection(_ section: Int) -> [<%=dataSourceItemName%>] {
        self.dataSource.itemsInSection(section)
    }

    func itemAtIndexPath(_ path: IndexPath) -> <%=dataSourceItemName%> {
        self.dataSource.itemAtIndexPath(path)
    }

    func indexPath(for item: <%=dataSourceItemName%>) -> IndexPath? {
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
    <%_ } -%>
}


extension <%=presenterName%>: <%=moduleName%>InteractorOutput {}
<% if (useDataSource) { %>

extension <%=presenterName%>: SectionDataSourceDelegate {
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
<%_ } -%>
