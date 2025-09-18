Class IEEE.Benchmark
{

ClassMethod execute(length As %Integer = 1000000)
{
	do ..KillExtent()
	do ##class(IEEE.SumFloat).Benchmark(length)
	do ..KillExtent()
	do ##class(IEEE.SumDecimalWithScale).Benchmark(length)
	do ..KillExtent()
	do ##class(IEEE.SumDouble).Benchmark(length)
	do ..KillExtent()
	do ##class(IEEE.SumDecimalWithScale).Benchmark(length)
	do ..KillExtent()
	do ##class(IEEE.SumFloat).Benchmark(length)
	do ..KillExtent()
	do ##class(IEEE.SumDouble).Benchmark(length)
	do ..KillExtent()
	do ##class(IEEE.SumDouble).Benchmark(length)
	do ..KillExtent()
	do ##class(IEEE.SumFloat).Benchmark(length)
	do ..KillExtent()
	do ##class(IEEE.SumDecimalWithScale).Benchmark(length)
	do ..KillExtent()
}

ClassMethod KillExtent()
{
	do ##class(IEEE.SumDecimalWithScale).%KillExtent()
	do ##class(IEEE.SumDouble).%KillExtent()
	do ##class(IEEE.SumFloat).%KillExtent()
}

}
