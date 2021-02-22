Class Riches.Account Extends %Persistent
{

Property OpenDate As %Date;

Property CloseDate As %Date;

Property StatementDate As %Date;

Property Institution As %String;

Property StartBalance As %Currency;

Property CurrBalance As %Currency;

Property StatementBalance As %Currency;

Property Type As %String(VALUELIST = ",Checking,Savings,Credit Card");

Property Website As %String;

Property Nickname As %String;

ClassMethod OutputFormData(iNickname As %String = "", iStartBalance As %String = "") As %Status
{
	Set q = """"
	Set qHidden = q_"hidden"_q
	Set qRadio = q_"radio"_q
	Set qSize = q_"50"_q
	Set qSubmit = q_"submit"_q
	Set qText = q_"text"_q
	Set qID = "iChoose"
	Write "<input type=",qHidden," id=",qID," name=",qID," size=",qSize," value=",q,"Account",q,"><br>",!
	Write "<table><tr><td>",!
	Set qName = q_"iType"_q
	Set qID = q_"TypeChecking"_q
	Write "<input type=",qRadio," id=",qID," name=",qName," value=",qID,">",!
	Write "<label for=",qID,">Checking</label><br>",!
	Write "</td><td>",!
	Set qID = q_"TypeSavings"_q
	Write "<input type=",qRadio," id=",qID," name=",qName," value=",qID,">",!
	Write "<label for=",qID,">Savings</label><br>",!
	Write "</td><td>",!
	Set qID = q_"TypeCreditCard"_q
	Write "<input type=",qRadio," id=",qID," name=",qName," value=",qID,">",!
	Write "<label for=",qID,">Credit Card</label><br>",!
	Write "</td></tr></table>",!
	Write "<table><tr><td>"
	Set qID=q_"iNickname"_q
	Write "<label for=",qID,">Nickname:</label>",!
	Write "</td><td>",!
	Write "<input type=",qText," id=",qID," name=",qID," size=",qSize," value=",q,$Get(iNickname),q,"><br>",!
	Write "</td></tr>",!
	Write "<tr><td>",!
	Set qID=q_"iStartBalance"_q
	Write "<label for=",qID,">Start Balance:</label>",!
	Write "</td><td>",!
	Write "<input type=",qText," id=",qID," name=",qID," size=",qSize," value=",q,$Get(iStartBalance),q,"><br>",!
	Write "</td></tr></table>",!
	Set qValue = q_"Submit"_q
	Write "<input type=",qSubmit," value=",qValue,">",!
	Quit $$$OK
}

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

ClassMethod SubmitFormData(ByRef pRequestData) As %Status
{
	Do ##class(Util).DebugTEST("Riches.Account - SubmitFormData")
	Do ##class(Util).DebugMerge("pRequestData = ",.pRequestData)
	Set tSC = $$$OK
	If ($Data(pRequestData("iNickname",1))) {
		Set iNickname = pRequestData("iNickname",1)
	}
	If ($Data(pRequestData("iStartBalance",1))) {
		Set iStartBalance = pRequestData("iStartBalance",1)
	}
	If ($Data(pRequestData("iType",1))) {
		Set iType = pRequestData("iType",1)
		Set iType = $ZCONVERT(iType,"U")
		If (iType [ "CHECK") Set iType = "Checking"
		If (iType [ "CRED") Set iType = "Credit Card"
		If (iType [ "SAV") Set iType = "Savings"
	}
	If ($Get(iNickname) '= "") {
		Set objCategory = ##class(Riches.Account).%New()
		Set objCategory.Nickname = iNickname
		Set objCategory.StartBalance = $Get(iStartBalance)
		Set objCategory.Type = $Get(iType)
		Set tSC = objCategory.%Save()
		Do ##class(Util).DebugStatus(tSC)
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
