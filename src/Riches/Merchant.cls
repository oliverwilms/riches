Class Riches.Merchant Extends %Persistent
{

Property Nickname As %String;

Property DefaultCat As Category;

Property DefaultSubCat As SubCategory;

Storage Default
{
<Data name="MerchantDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Nickname</Value>
</Value>
<Value name="3">
<Value>DefaultCat</Value>
</Value>
<Value name="4">
<Value>DefaultSubCat</Value>
</Value>
</Data>
<DataLocation>^Riches.MerchantD</DataLocation>
<DefaultData>MerchantDefaultData</DefaultData>
<IdLocation>^Riches.MerchantD</IdLocation>
<IndexLocation>^Riches.MerchantI</IndexLocation>
<StreamLocation>^Riches.MerchantS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
