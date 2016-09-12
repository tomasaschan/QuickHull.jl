using Documenter, QuickHull

makedocs()

deploydocs(
    repo   = "github.com/tlycken/QuickHull.jl",
    julia  = "0.5",
    deps   = Deps.pip("pygments", "mkdocs", "python-markdown-math"),
)
