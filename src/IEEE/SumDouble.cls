Class IEEE.SumDouble Extends %Persistent
{

Property sum1 As %Double;

Property sum2 As %Double;

Property result As %Double;

ClassMethod calculate(sum1 As %Double, sum2 As %Double)
{
	set obj = ..%New()
	set obj.sum1 = sum1
	set obj.sum2 = sum2
	set obj.result = sum1 + sum2
	;return obj.%Save()
	return obj
}

ClassMethod execExample()
{
	write !,"=======================%Double=======================",!
	set obj = ..calculate($double(0.2), $double(0.1))
	write !,obj.sum1_" + "_obj.sum2_"="_obj.result
	write !,"=======================OBJ=======================",!
	zwrite obj
	write !,"=================================================",!
}

ClassMethod Benchmark(length As %Integer = 500000)
{
	do ##class(IEEE.SumDouble).%KillExtent()
	set tempoInicial = $zhorolog
    for i=1:1:length {

        set sum1 = $double($random(154000)/100)
        set sum2 = $double($random(154000)/100 + 1)
		set double = ((sum1+$double(0.1))*$double(1.01))/$double(sum2) - $double(0.0001)
        do ..calculate(sum1, double)
    }
    set tempoFinal = $zhorolog
    set elapsed = tempoFinal - tempoInicial
    write !,"Tempo de execução (Double): "_elapsed_" segundos."
    quit
}

Storage Default
{
<Data name="SumDoubleDefaultData">
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
<DataLocation>^IEEE.SumDoubleD</DataLocation>
<DefaultData>SumDoubleDefaultData</DefaultData>
<IdLocation>^IEEE.SumDoubleD</IdLocation>
<IndexLocation>^IEEE.SumDoubleI</IndexLocation>
<StreamLocation>^IEEE.SumDoubleS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
