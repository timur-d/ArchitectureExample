<%_ 
fileName = `${moduleName}ViewOutput`
let viewModelName = `${moduleName}ViewModel`
let useDataSource = dataSourceItemName
-%><%- include("../../fileCommonHeader.ejs"); %>

<% if (useDataSource) { -%>
import UIKit
<% } -%>

protocol <%= moduleName %>ViewOutput {

    /**
        Notify presenter that view is ready
    */
    func viewIsReady()
    <%_ if (useViewModel) { %>
    /**
        View model. Current state
    */
    var model: <%= viewModelName %> { get }

    /**
        View updates model from user interactions. Use notify=true carefully to avoid loop.
    */
    func update(with updates: [<%= moduleName %>ViewModel.Updates], notify: Bool)

    <%_ } -%>
    <%_ if (useDataSource) { %>
    /**
        DataSource methods
    */
    func itemsInSection(_ section: Int) -> [<%= dataSourceItemName %>]

    func itemAtIndexPath(_ path: IndexPath) -> <%= dataSourceItemName %>

    func indexPath(for item: <%= dataSourceItemName %>) -> IndexPath?

    func numberOfItemsInSection(_ section: Int) -> Int

    func numberOfSections() -> Int

    func sectionIdForSection(_ section: Int) -> String
    <%_ } -%>
}
