Class Riches.Transact Extends %Persistent
{

Property Account As Account;

Property AmountCredit As %Currency;

Property AmountDebit As %Currency;

Property Category As Category;

Property SubCategory As SubCategory;

Property Merchant As Merchant;

Property TranDate As %Date;

Property TranTime As %Time;

Property OtherSide As Transact;

ClassMethod SubmitFormData(ByRef pRequestData, Output pAction, Output pId) As %Status
{
	Do ##class(Util).DebugTEST("Riches.Transact - SubmitFormData")
	Do ##class(Util).DebugMerge("pRequestData = ",.pRequestData)
	Set tSC = $$$OK
	If ($Data(pRequestData("iAccount",1))) {
		Set iAccount = pRequestData("iAccount",1)
	}
	If ($Get(iAccount) = "") {
		Set tSC = $$$ADDSC(tSC,$$$ERROR($$$GeneralError,"Account is required."))
	}
	Set iAmountCredit = 0
	If ($Data(pRequestData("iAmountCredit",1))) {
		Set iAmountCredit = pRequestData("iAmountCredit",1)
	}
	Set iAmountDebit = 0
	If ($Data(pRequestData("iAmountDebit",1))) {
		Set iAmountDebit = pRequestData("iAmountDebit",1)
	}
	If ($Data(pRequestData("iCategory",1))) {
		Set iCategory = pRequestData("iCategory",1)
	}
	If ($Get(iCategory) = "") {
		Set tSC = $$$ADDSC(tSC,$$$ERROR($$$GeneralError,"Category is required."))
	}
	If ($Data(pRequestData("iMerchant",1))) {
		Set iMerchant = pRequestData("iMerchant",1)
	}
	If ($Get(iMerchant) = "") {
		Set tSC = $$$ADDSC(tSC,$$$ERROR($$$GeneralError,"Merchant is required."))
	}
	Set iTranDate = $Piece($Horolog,",",1)
	Set iTranTime = $Piece($Horolog,",",2)
	If ($Data(pRequestData("iTranDate",1))) {
		Set iTranDate = pRequestData("iTranDate",1)
	}
	If ($Data(pRequestData("iTranTime",1))) {
		Set iTranTime = pRequestData("iTranTime",1)
	}
	TSTART
	&SQL(INSERT INTO Riches.Transact (Account,AmountCredit,AmountDebit,Category,Merchant,TranDate,TranTime)
		VALUES (:iAccount,:iAmountCredit,:iAmountDebit,:iCategory,:iMerchant,:iTranDate,:iTranTime))
	Do ##class(Util).DebugTEST("SQLCODE = "_SQLCODE)
	If SQLCODE TRollBack  Quit "Cannot withdraw, SQLCODE = "_SQLCODE
	/*&SQL(UPDATE A.Account
        SET A.Account.Balance = A.Account.Balance + :amount
        WHERE A.Account.AccountNum = :to)
    If SQLCODE TROLLBACK  QUIT "Cannot deposit, SQLCODE = "_SQLCODE
	*/
    TCOMMIT
	Do ##class(Util).DebugStatus(tSC)
	Quit tSC
}

Storage Default
{
<Data name="TransactDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Account</Value>
</Value>
<Value name="3">
<Value>AmountCredit</Value>
</Value>
<Value name="4">
<Value>AmountDebit</Value>
</Value>
<Value name="5">
<Value>Category</Value>
</Value>
<Value name="6">
<Value>SubCategory</Value>
</Value>
<Value name="7">
<Value>Merchant</Value>
</Value>
<Value name="8">
<Value>TranDate</Value>
</Value>
<Value name="9">
<Value>TranTime</Value>
</Value>
<Value name="10">
<Value>OtherSide</Value>
</Value>
</Data>
<DataLocation>^Riches.TransactD</DataLocation>
<DefaultData>TransactDefaultData</DefaultData>
<IdLocation>^Riches.TransactD</IdLocation>
<IndexLocation>^Riches.TransactI</IndexLocation>
<StreamLocation>^Riches.TransactS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
