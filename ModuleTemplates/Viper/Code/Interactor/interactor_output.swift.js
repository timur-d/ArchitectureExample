<%_ 
fileName = `${moduleName}InteractorOutput`
let interactorName = `${moduleName}Interactor`
-%><%- include("../../fileCommonHeader.ejs"); %>
import Foundation


protocol <%=interactorName%>Output: AnyObject {}
