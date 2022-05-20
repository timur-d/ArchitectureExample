<%_ 
fileName = `${moduleName}ViewInput`
let viewModelName = `${moduleName}ViewModel`
let useDataSource = dataSourceItemName
-%><%- include("../../fileCommonHeader.ejs"); %>
<% if (useDataSource) { %>
import SectionDataSource
<% } -%>

protocol <%= moduleName %>ViewInput: AnyObject {
    <%_ if (useViewModel) { -%>
    /**
        Updates view
    */
    func update(with updates: [<%= viewModelName %>.Updates])
    <%_ } -%>
    <%_ if (useDataSource) { %>
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
    <%_ } -%>
}
