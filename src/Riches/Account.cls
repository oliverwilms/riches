Class Riches.Account Extends %Persistent
{

Property OpenDate As %Date;

Property CloseDate As %Date;

Property StatementDate As %Date;

Property Institution As %String;

Property StartBalance As %Currency;

Property CurrBalance As %Currency;

Property StatementBalance As %Currency;

Property Type As %String;

Property Website As %String;

Property Nickname As %String;

ClassMethod OutputTableData(pWhere As %String = "", pTrClick As %String = "window.location='Transact.csp?iAccount=#';", pMaxRows = -1) As %Status
{
	Do ##class(Util).DebugTEST("Riches.Account - OutputTableData")
	Do ##class(Util).DebugTEST("pWhere = "_pWhere)
	Set tQuote = """"
	Set tSC = $$$OK
	Set tWHERE = ""
	If (pWhere '= "") Set tWHERE = " WHERE Session = '"_pWhere_"'"  // This did not return any result
	If (pWhere '= "") Set tWHERE = " WHERE Session LIKE '"_$TRANSLATE(pWhere," ","%")_"'"
	Set tQuery = "SELECT * FROM Riches.Account"_tWHERE
	Do ##class(Util).DebugTEST("tQuery = "_tQuery)
	Set tStatement = ##class(%SQL.Statement).%New()
	Set tSC = tStatement.%Prepare(.tQuery)  // Create a cached query
	If $$$ISERR(tSC) { Quit tSC }
	#dim tResult As %SQL.StatementResult
	Set tResult = tStatement.%Execute()
	IF (tResult.%SQLCODE=0) { /*WRITE !,"Created a query",!*/ }
	ELSEIF (tResult.%SQLCODE=-361) { /*WRITE !,"Query exists: ",tResult.%Message*/ }
	ELSE { /*WRITE !,"CREATE QUERY error: ",tResult.%SQLCODE," ",tResult.%Message*/ QUIT tSC}
 	While tResult.%Next() {
		Write !,"<tr onclick=",tQuote,$Replace(pTrClick,"#",tResult.ID),tQuote,">"
		Write !,"<td>",tResult.Nickname,"</td>"
		Write !,"<td>",tResult.Type,"</td>"
		Write !,"<td>",tResult.StartBalance,"</td></tr>"
	}
	Quit tSC
}

Storage Default
{
<Data name="AccountDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>OpenDate</Value>
</Value>
<Value name="3">
<Value>CloseDate</Value>
</Value>
<Value name="4">
<Value>StatementDate</Value>
</Value>
<Value name="5">
<Value>Institution</Value>
</Value>
<Value name="6">
<Value>StartBalance</Value>
</Value>
<Value name="7">
<Value>CurrBalance</Value>
</Value>
<Value name="8">
<Value>StatementBalance</Value>
</Value>
<Value name="9">
<Value>Type</Value>
</Value>
<Value name="10">
<Value>Website</Value>
</Value>
<Value name="11">
<Value>Nickname</Value>
</Value>
</Data>
<DataLocation>^Riches.AccountD</DataLocation>
<DefaultData>AccountDefaultData</DefaultData>
<IdLocation>^Riches.AccountD</IdLocation>
<IndexLocation>^Riches.AccountI</IndexLocation>
<StreamLocation>^Riches.AccountS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
