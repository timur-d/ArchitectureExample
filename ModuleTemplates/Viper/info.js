// name: Viper
// summary: Swift Viper module template.
// author: Mikhail Mulyar
// version: 0.1.0
// license: MIT

const path = require('path')
const fs = require('fs')

module.exports = {
    files: [
        "Tests/Presenter/presenter_tests.swift.js",
        "Tests/View/view_tests.swift.js",
        "Tests/Configurator/configurator_tests.swift.js",
        "Tests/Interactor/interactor_tests.swift.js",
        "Tests/Router/router_tests.swift.js",
        "Code/Presenter/module_input.swift.js",
        "Code/Presenter/presenter.swift.js",
        "Code/View/view_input.swift.js",
        "Code/View/view_output.swift.js",
        "Code/View/viewcontroller.swift.js",
        "Code/View/viewmodel.swift.js",
        "Code/Configurator/configurator.swift.js",
        "Code/Interactor/interactor_output.swift.js",
        "Code/Interactor/interactor.swift.js",
        "Code/Interactor/interactor_input.swift.js",
        "Code/Router/router.swift.js",
        "Code/Router/router_input.swift.js"
    ].reduce((r, v) => {
        r[v] = { "type": "ejs" }
        return r
    }, {}),
    variables: {
        copyright: {
            title: "Copyright",
            description: "Placed on top of file",
            type: "string"
        },
        moduleName: {
            title: "Module Name",
            description: "Name of the module",
            type: "string",
        },
        productName: {
            title: "Product Name",
            description: "Name of the product target",
            type: "string",
        },
        developerName: {
            title: "Developer Name",
            type: "string",
        },
        dateLine: {
            title: "Date line in format MM/DD/YYYY.",
            type: "string",
        },
        fullYear: {
            title: "Date line in format MM/DD/YYYY.",
            type: "string",
        },
        useCoordinator: {
            title: "Use Coordinator",
            description: "true: weak protocol as Router, false: class instance with protocol",
            type: "boolean",
            default: true
        },
        useViewModel: {
            title: "Use ViewModel",
            description: "communication in view <-> presenter with model updates",
            type: "boolean",
            default: true
        },
        dataSourceItemName: {
            title: "DataSource item name",
            description: "use SectionDataSource for managing collection/table, if empty then not used",
            type: "string"
        },
        manualTestMocks: {
            title: "Generate manual mocks",
            description: "generate clases for manual mocks implementing",
            type: "boolean",
            default: false
        },
    },
    postProcessor: (vfs, variables) => {
        const codePath = path.join(
            "ArchitecturePrototype", 
            "Modules", 
            "Viper", 
            variables.moduleName
        )
        const testPath = path.join(
            "ArchitecturePrototypeTests",
            "Modules",
            "Viper",
            variables.moduleName
        )

        let resultVfs = {}

        let nameReplacementDictionary = {
            "presenter_tests.swift.js": `${variables.moduleName}PresenterTests.swift`,
            "view_tests.swift.js": `${variables.moduleName}ViewTests.swift`,
            "configurator_tests.swift.js": `${variables.moduleName}ConfiguratorTests.swift`,
            "interactor_tests.swift.js": `${variables.moduleName}InteractorTests.swift`,
            "router_tests.swift.js": `${variables.moduleName}RouterTests.swift`,
            "module_input.swift.js": `${variables.moduleName}ModuleInput.swift`,
            "presenter.swift.js": `${variables.moduleName}Presenter.swift`,
            "view_input.swift.js": `${variables.moduleName}ViewInput.swift`,
            "view_output.swift.js": `${variables.moduleName}ViewOutput.swift`,
            "viewcontroller.swift.js": `${variables.moduleName}ViewController.swift`,
            "viewmodel.swift.js": `${variables.moduleName}ViewModel.swift`,
            "configurator.swift.js": `${variables.moduleName}Configurator.swift`,
            "interactor_output.swift.js": `${variables.moduleName}InteractorOutput.swift`,
            "interactor.swift.js": `${variables.moduleName}Interactor.swift`,
            "interactor_input.swift.js": `${variables.moduleName}InteractorInput.swift`,
            "router.swift.js": `${variables.moduleName}Router.swift`,
            "router_input.swift.js": `${variables.moduleName}RouterInput.swift`,
            
        }

        // use only non empty results
        for (key of Object.keys(vfs).filter(key => vfs[key])) {
            let value = vfs[key]
            let baseName = path.basename(key)
            let filePath = key.replace(
                baseName, 
                (nameReplacementDictionary[baseName] ?? baseName.replace(".js", "").replace(".ejs", ""))
            )
                .replace(`Code${path.sep}`, '')
                .replace(`Tests${path.sep}`, '')

            if (key.startsWith("Code/")) {
                resultVfs[path.join(codePath, filePath)] = value
            } else if (key.startsWith("Tests/")) { // tests
                resultVfs[path.join(testPath, filePath)] = value
            }
        }

        // post actions required: sourcery
        // no supported by module-gen yet... 
        
        return resultVfs
    }
}
