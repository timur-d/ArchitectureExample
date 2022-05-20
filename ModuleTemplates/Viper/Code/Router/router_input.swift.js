<%_ 
fileName = `${moduleName}RouterInput`
-%><%- include("../../fileCommonHeader.ejs"); %>

import Foundation

<% if (useCoordinator) { -%>
// typealias Any<%= moduleName %>Context = <%= moduleName %>Context
public protocol Any<%= moduleName %>Context: AnyObject {

}

public protocol <%= moduleName %>RouterInput: AnyObject {

}
<% } else { -%>
protocol <%= moduleName %>RouterInput {
    /**
        Weak reference to view input(view controller)
    */
    var viewInput: <%= moduleName %>ViewInput! { get }
}
<% } -%>