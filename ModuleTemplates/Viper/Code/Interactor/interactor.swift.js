<%_ 
fileName = `${moduleName}Interactor`
let interactorName = `${moduleName}Interactor`
-%><%- include("../../fileCommonHeader.ejs"); %>

import Foundation


final class <%=interactorName%>: <%=interactorName%>Input {
    weak var output: <%=interactorName%>Output!
}
