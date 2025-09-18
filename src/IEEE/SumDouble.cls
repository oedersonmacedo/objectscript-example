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
	/**Resultado:
.20000000000000001111 + .10000000000000000556=.30000000000000004441
=======================OBJ=======================
obj=2@IEEE.SumDouble  ; <OREF,refs=1>
+----------------- general information ---------------
|      oref value: 2
|      class name: IEEE.SumDouble
| reference count: 1
+----------------- attribute values ------------------
|       %Concurrency = 1  <Set>
|             result = $double(.30000000000000004441)
|               sum1 = $double(.20000000000000001111)
|               sum2 = $double(.10000000000000000556)
+-----------------------------------------------------

=================================================
*/
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

ClassMethod errorPrecision()
{
	write !,$double(0.1) + $double(0.2)_" Deveria ser: "_(0.1 + 0.2)
	/// Resultado: .30000000000000004441 Deveria ser: .3
	write !,$double(666.7) - $double(666.6)_" Deveria ser: "_(666.7-666.6)
	/// Resultado: .10000000000002273736 Deveria ser: .1
	write !,$double(33.3) * $double(3)_" Deveria ser: "_(33.3 * 3)
	/// Resultado:
	write !,$double(12.2) / $double(0.1)_" Deveria ser: "_(12.2 / 0.1)
	/// Resultado: 99.899999999999991473 Deveria ser: 99.9
	write !,"Interação de $double com outro numérico: "
			_($double(0.1) + $double(0.2) + 1)
			_" Deveria ser: "_(0.1 + 0.2 + 1)
	/// Interação de $double com outro numérico: 1.3000000000000000444 Deveria ser: 1.3
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
