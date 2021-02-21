Class Riches.Transact Extends %Persistent
{

Property Account As Account;

Property Amount As %Currency;

Property Category As Category;

Property SubCategory As SubCategory;

Property Merchant As Merchant;

Property TranDate As %Date;

Property TranTime As %Time;

Property OtherSide As Transact;

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
<Value>Amount</Value>
</Value>
<Value name="4">
<Value>Category</Value>
</Value>
<Value name="5">
<Value>SubCategory</Value>
</Value>
<Value name="6">
<Value>TranDate</Value>
</Value>
<Value name="7">
<Value>TranTime</Value>
</Value>
<Value name="8">
<Value>OtherSide</Value>
</Value>
<Value name="9">
<Value>Merchant</Value>
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
