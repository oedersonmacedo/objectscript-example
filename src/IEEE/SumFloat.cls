Class IEEE.SumFloat Extends %Persistent
{

Property sum1 As %Float;

Property sum2 As %Float;

Property result As %Float;

ClassMethod calculate(sum1 As %Float, sum2 As %Float)
{
	set obj = ..%New()
	set obj.sum1 = sum1
	set obj.sum2 = sum2
	set obj.result = sum1 + sum2
	;do obj.%Save()
	quit obj
}

ClassMethod execExample()
{
	write !,"=======================%Float=======================",!
	set obj = ..calculate(0.2, 0.1)
	write !,obj.sum1_" + "_obj.sum2_"="_obj.result
	write !,"=======================OBJ=======================",!
	zwrite obj
	write !,"=================================================",!
}

ClassMethod Benchmark(length As %Integer = 50000)
{
	do ##class(IEEE.SumFloat).%KillExtent()
	set tempoInicial = $zhorolog
    for i=1:1:length {
        set sum1 = $random(154000)/100
        set sum2 = $random(154000)/100 + 1
		set decimal = ((sum1+0.1) * 1.01)/sum2 - 0.0001
        do ..calculate(sum1, decimal)
    }
    set tempoFinal = $zhorolog
    set elapsed = tempoFinal - tempoInicial
    write !,"Tempo de execução (Float): "_elapsed_" segundos."
    quit
}

Storage Default
{
<Data name="SumFloatDefaultData">
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
<DataLocation>^IEEE.SumFloatD</DataLocation>
<DefaultData>SumFloatDefaultData</DefaultData>
<IdLocation>^IEEE.SumFloatD</IdLocation>
<IndexLocation>^IEEE.SumFloatI</IndexLocation>
<StreamLocation>^IEEE.SumFloatS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
