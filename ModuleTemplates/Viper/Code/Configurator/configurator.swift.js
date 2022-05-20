<%_ 
fileName = `${moduleName}Configurator`
let configuratorName = `${moduleName}Configurator`
let moduleOutputName = `${moduleName}ModuleOutput`
let moduleInputName = `${moduleName}ModuleInput`
let controllerName = `${moduleName}ViewController`
let interactorName = `${moduleName}Interactor`
let routerName = `${moduleName}Router`
let presenterName = `${moduleName}Presenter`

let configureMethodPrefix = '    public static func configure('
let configureParameters = ['input: Any? = nil']

if (useCoordinator) {
    configureParameters.push(`context: Any${moduleName}Context`)
    configureParameters.push(`router: ${moduleName}RouterInput`)
}

configureMethodPrefix = [
    configureMethodPrefix,
    configureParameters.join(",\n" + " ".repeat(configureMethodPrefix.length)),
    `) -> (${moduleName}ViewType, ${moduleInputName}) {`
].join('')
-%><%- include("../../fileCommonHeader.ejs"); %>

import Foundation


public final class <%= configuratorName %>: AutoInjectableModule {
    // MARK: - <%= moduleOutputName %>
<%- configureMethodPrefix %>
        let interactor = <%= interactorName %>()
        <%_ if (!useCoordinator) { -%>
        let router = <%= routerName %>()
        <%_ } -%>
        let presenter = <%= presenterName %>(interactor: interactor, router: router)
        let view = <%= controllerName %>(output: presenter)

        interactor.output = presenter
        <%_ if (!useCoordinator) { -%>
        router.viewController = view
        <%_ } else { -%>
        presenter.context = context
        presenter.viewInput = view
        <%_ } -%>
        return (view, presenter)
    }
}