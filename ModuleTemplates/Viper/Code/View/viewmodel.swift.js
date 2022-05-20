<%_ 
fileName = `${moduleName}ViewModel`
let viewModelName = `${moduleName}ViewModel`
let useDataSource = dataSourceItemName
if (useViewModel) {
-%><%- include("../../fileCommonHeader.ejs"); %>


// /sourcery/: fileGenerationPath = "../../Modules/Viper/<%= moduleName %>/View/Generated"
struct <%= viewModelName %>: AutoObjectDiff, AutoEquatable, AutoLenses {
    static var initial: <%= viewModelName %> {
        .init(value: false)
    }

    let value: Bool
}
<%_ } -%>