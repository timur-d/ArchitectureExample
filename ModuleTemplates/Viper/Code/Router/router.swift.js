<%_ 
fileName = `${moduleName}Router`
let controllerName = `${moduleName}ViewController`
let routerName = `${moduleName}Router`

if (!useCoordinator) {
-%><%- include("../../fileCommonHeader.ejs"); %>

import BaseProtocolsLibrary


final class <%= routerName %>: RouterProtocol {

    // MARK: - Variables

    /**
        ViewController
    */
    typealias ViewController = <%= controllerName %>
    weak var viewController: <%= controllerName %>!

}


// MARK: - <%= routerName %>Input
extension <%= routerName %>: <%= routerName %>Input {
    var viewInput: <%= moduleName %>ViewInput! { self.viewController }
}
<% } -%>