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
	;do obj.%Save()
	return obj
}

ClassMethod execExample()
{
	write !,"=======================%Decimal sem SCALE=======================",!
	set obj = ..calculate(0.2, 0.1)
	write !,obj.sum1_" + "_obj.sum2_"="_obj.result
	write !,"=======================OBJ=======================",!
	zwrite obj
	write !,"=================================================",!
	/**Resultado:
=======================%Decimal sem SCALE=======================

.2 + .1=.3
=======================OBJ=======================
obj=2@IEEE.SumDecimal  ; <OREF,refs=1>
+----------------- general information ---------------
|      oref value: 2
|      class name: IEEE.SumDecimal
| reference count: 1
+----------------- attribute values ------------------
|       %Concurrency = 1  <Set>
|             result = .3
|               sum1 = .2
|               sum2 = .1
+-----------------------------------------------------

=================================================
*/
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
