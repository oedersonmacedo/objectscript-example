Class IEEE.SumDecimalWithScale Extends %Persistent
{

Property sum1 As %Decimal(SCALE = 10);

Property sum2 As %Decimal(SCALE = 10);

Property result As %Decimal(SCALE = 4);

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
	write !,"=======================%Decimal com SCALE=======================",!
	set obj = ..calculate(0.2, 0.1)
	write !,obj.sum1_" + "_obj.sum2_"="_obj.result
	write !,"=======================OBJ=======================",!
	zwrite obj
	write !,"=================================================",!
	/**Resultado:
=======================%Decimal com SCALE=======================

.2 + .1=.3
=======================OBJ=======================
obj=2@IEEE.SumDecimalWithScale  ; <OREF,refs=1>
+----------------- general information ---------------
|      oref value: 2
|      class name: IEEE.SumDecimalWithScale
|           %%OID: $lb("2","IEEE.SumDecimalWithScale")
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

ClassMethod Benchmark(length As %Integer = 50000)
{
	do ##class(IEEE.SumDecimalWithScale).%KillExtent()
	set tempoInicial = $zhorolog
    for i=1:1:length {
        set sum1 = $random(154000)/100
        set sum2 = $random(154000)/100 + 1
		set float = ((sum1+0.1) * 1.01)/sum2 - 0.0001
        do ..calculate(sum1, float)
    }
    set tempoFinal = $zhorolog
    set elapsed = tempoFinal - tempoInicial
    write !,"Tempo de execução (Decimal): "_elapsed_" segundos."
    quit
}

Storage Default
{
<Data name="SumDecimalWithScaleDefaultData">
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
<DataLocation>^IEEE.SumDecimalWithScaleD</DataLocation>
<DefaultData>SumDecimalWithScaleDefaultData</DefaultData>
<IdLocation>^IEEE.SumDecimalWithScaleD</IdLocation>
<IndexLocation>^IEEE.SumDecimalWithScaleI</IndexLocation>
<StreamLocation>^IEEE.SumDecimalWithScaleS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
