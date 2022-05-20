<%_ 
fileName = `${moduleName}ViewController`
let controllerName = `${moduleName}ViewController`
let viewModelName = `${moduleName}ViewModel`
let useDataSource = dataSourceItemName
let controllerNamePadding = " ".repeat(controllerName.length)
-%><%- include("../../fileCommonHeader.ejs"); %>

import UIKit
<%_ if (useDataSource) { -%>
import SectionDataSource
<% } %>

public protocol <%= moduleName %>ViewType: BaseViewController {}

// all secondary ViewController's must conform to `injectionExportType`.
// sourcery: injectionExportType=<%= moduleName %>ViewType
final class <%= controllerName %>: BaseViewController, 
            <%= controllerNamePadding %>  <%= moduleName %>ViewType {

    // MARK: - Initializers
    required init(output: <%= moduleName %>ViewOutput) {
        self.output = output
        super.init()

        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - Variables
    let output: <%= moduleName %>ViewOutput


    // MARK: - Initialize
    func setup() {

    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
}


// MARK: - <%= moduleName %>ViewInput
extension <%= controllerName %>: <%= moduleName %>ViewInput {
    <%_ if (useViewModel) { -%>
    func update(with updates: [<%= moduleName %>ViewModel.Updates]) {

    }<%_ } %>
    <%_ if (useDataSource) { %>
    func contentDidUpdate(updates: DataSourceUpdates) {
        switch updates {
        case .reload:
            break
        case .initial(let changes):
            break
        case .update(let changes):
            break
        }
    }

    func searchContentDidUpdate(updates: DataSourceUpdates) {
        switch updates {
        case .reload:
            break
        case .initial:
            break
        case .update:
            break
        }
    }

    func didUpdateSearchState(isSearching: Bool) {}
    <%_ } %>
}