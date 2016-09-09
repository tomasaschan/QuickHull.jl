# Performance

The current implementation is not optimized at all, but still performs quite
well on small enough data sets.

Using [`BenchmarkTools`][bmt] we can find out just how well:

```julia
julia> using BenchmarkTools, QuickHull

julia> points = map(Vec, rand(25), rand(25));

julia> @benchmark qhull(points)
BenchmarkTools.Trial: 
  samples:          10000
  evals/sample:     9
  time tolerance:   5.00%
  memory tolerance: 1.00%
  memory estimate:  5.61 kb
  allocs estimate:  66
  minimum time:     2.15 μs (0.00% GC)
  median time:      2.47 μs (0.00% GC)
  mean time:        3.86 μs (31.64% GC)
  maximum time:     638.79 μs (98.87% GC)
```

The data set here is quite small, but it needs to be for the hull to have a
shape that is more interesting than the square ``[1,2]^2``. We can increase
the data set size to convince ourselves that the library still performs quite
well. To avoid different runs interfering with each-other, we run `gc()` before
each time:

```julia
julia> points2 = map(Vec, rand(1_000_000), rand(1_000_000));

julia> gc(); @time qhull(points2);
  0.053300 seconds (407 allocations: 59.894 MB, 4.72% gc time)

julia> gc(); @time qhull(points2);
  0.054250 seconds (407 allocations: 59.894 MB, 4.64% gc time)
```

However, these tests are also pretty naïve - for example, the points are all
constrained to a small region with a simple shape, and so fit the algorithm
extremely well.

If you have a use case where this library does not peform well enough, please do
file an issue, and we can try to optimize it together.

[bmt]: https://github.com/JuliaCI/BenchmarkTools.jl