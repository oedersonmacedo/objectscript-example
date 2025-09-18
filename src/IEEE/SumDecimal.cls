Class IEEE.SumDecimal Extends %Persistent
{

Property sum1 As %Decimal;

Property sum2 As %Decimal;

Property result As %Decimal;

ClassMethod calculate(sum1 As %Decimal, sum2 As %Decimal)
{
	set obj = ..%New()
	set obj.sum1 = sum1
	set obj.sum2 = sum2
	set obj.result = sum1 + sum2
	do obj.%Save()
	write !,obj.sum1_" + "_obj.sum2_"="_obj.result
	write !,"=======================OBJ=======================",!
	zwrite obj
	write !,"=================================================",!
}

ClassMethod execExample()
{
	write !,"=======================%Float=======================",!
	do ..calculate(0.2, 0.1)
}

Storage Default
{
<Data name="SumDecimalDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>sum1</Value>
</Value>
<Value name="3">
<Value>sum2</Value>
</Value>
<Value name="4">
<Value>result</Value>
</Value>
</Data>
<DataLocation>^IEEE.SumDecimalD</DataLocation>
<DefaultData>SumDecimalDefaultData</DefaultData>
<IdLocation>^IEEE.SumDecimalD</IdLocation>
<IndexLocation>^IEEE.SumDecimalI</IndexLocation>
<StreamLocation>^IEEE.SumDecimalS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
