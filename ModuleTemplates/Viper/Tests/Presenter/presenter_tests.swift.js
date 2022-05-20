<%_ 
fileName = `${moduleName}PresenterTests`
let useDataSource = dataSourceItemName
-%><%- include("../../fileCommonHeader.ejs"); %>

import XCTest
@testable import <%= productName %>
<% if (useDataSource) { -%>
import SectionDataSource
<% } %>

class <%= moduleName %>PresenterTest: XCTestCase {
    private var interactor: MockInteractor!
    private var router: MockRouter!
    private var view: MockViewController!
    <%_ if (useCoordinator) { -%>
    private let context = Any<%= moduleName %>ContextMock()
    <%_ } -%>

    private var presenter: <%= moduleName %>Presenter!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        interactor = MockInteractor()
        router = MockRouter()
        view = MockViewController()

//         presenter = <%= moduleName %>Presenter(
//             interactor: interactor,
//             router: router
//         )
//         presenter.viewInput = view
//         presenter.context = context
    }

    override func tearDown() {
        presenter = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    <%_ if (manualTestMocks) { -%>
    class MockInteractor: <%= moduleName %>InteractorInput {}

    class MockRouter: <%= moduleName %>RouterInput {
        <%_ if (useCoordinator) { -%>
        <%_ } else { -%>
        weak var viewController: <%= moduleName %>ViewController!

        var viewInput: <%= moduleName %>ViewInput {
            return self.viewController
        }
        <%_ } -%>
    }

    class MockViewController: <%= moduleName %>ViewInput {
        func setupNodes() {}
        <%_ if (useViewModel) { -%>
        func update(updates: [<%= moduleName %>ViewModel.Updates], animated: Bool) {}
        <%_ } -%>
        <%_ if (useDataSource) { -%>
        func contentDidUpdate(updates: DataSourceUpdates) {}

        func searchContentDidUpdate(updates: DataSourceUpdates) {}

        func didUpdateSearchState(isSearching: Bool) {}
        <%_ } -%>
    }
    <%_ } else { -%>
    class MockInteractor: <%= moduleName %>InteractorInputMock {}
    class MockRouter: <%= moduleName %>RouterInputMock {}
    class MockViewController: <%= moduleName %>ViewInputMock {}
    <%_ } -%>
}
