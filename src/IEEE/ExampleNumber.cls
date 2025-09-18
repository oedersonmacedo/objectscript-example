Class IEEE.ExampleNumber Extends %Persistent
{

/// %Float está **deprecated**. Representa número em ponto flutuante,
/// mas deve ser substituído por %Double ou %Decimal.
/// Armazena valores como ponto flutuante, podendo gerar imprecisão.
Property numFloat As %Float;

/// %Double é ponto flutuante IEEE 64 bits (precisão binária).
/// Bom para cálculos científicos, mas pode apresentar imprecisão
/// em operações financeiras ou de alta precisão decimal.
Property numDouble As %Double;

/// %Decimal é ponto fixo.
/// Excelente para valores monetários, pois mantém a precisão
/// decimal exata sem arredondamentos binários inesperados.
Property numDecimal As %Decimal(SCALE = 10);

ClassMethod Demo(value = 123.456789)
{
    set obj = ..%New()
    set obj.numFloat = value
    set obj.numDouble = value
    set obj.numDecimal = value
    do obj.%Save()
    write !,"Valores armazenados:"
    write !,"numFloat  = ", obj.numFloat
    write !,"numDouble = ", obj.numDouble
    write !,"numDecimal= ", obj.numDecimal
	write !,"-----------------OBJ-----------------",!
	zwrite obj
	write !,"-------------------------------------",!
	/**Resultado:
Valores armazenados:
numFloat  = 123.456789
numDouble = 123.45678900000000056
numDecimal= 123.456789
-----------------OBJ-----------------
obj=2@IEEE.ExampleNumber  ; <OREF,refs=1>
+----------------- general information ---------------
|      oref value: 2
|      class name: IEEE.ExampleNumber
|           %%OID: $lb("8","IEEE.ExampleNumber")
| reference count: 1
+----------------- attribute values ------------------
|       %Concurrency = 1  <Set>
|         numDecimal = 123.456789
|          numDouble = $double(123.45678900000000056)
|           numFloat = 123.456789
+-----------------------------------------------------

-------------------------------------
*/


    quit
}

Storage Default
{
<Data name="ExampleNumberDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>numFloat</Value>
</Value>
<Value name="3">
<Value>numDouble</Value>
</Value>
<Value name="4">
<Value>numDecimal</Value>
</Value>
</Data>
<DataLocation>^IEEE.ExampleNumberD</DataLocation>
<DefaultData>ExampleNumberDefaultData</DefaultData>
<IdLocation>^IEEE.ExampleNumberD</IdLocation>
<IndexLocation>^IEEE.ExampleNumberI</IndexLocation>
<StreamLocation>^IEEE.ExampleNumberS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
