Class Riches.Category Extends %Persistent
{

Property Type As %String;

Property Nickname As %String;

Property SortOrder As %String;

Storage Default
{
<Data name="CategoryDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Type</Value>
</Value>
<Value name="3">
<Value>Nickname</Value>
</Value>
<Value name="4">
<Value>SortOrder</Value>
</Value>
</Data>
<DataLocation>^Riches.CategoryD</DataLocation>
<DefaultData>CategoryDefaultData</DefaultData>
<IdLocation>^Riches.CategoryD</IdLocation>
<IndexLocation>^Riches.CategoryI</IndexLocation>
<StreamLocation>^Riches.CategoryS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
