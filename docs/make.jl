using Documenter

makedocs()

deploydocs(
    deps   = Deps.pip("mkdocs", "python-markdown-math"),
    repo   = "github.com/tlycken/QuickHull.jl",
    julia  = "0.5",
    osname = "linux"
)
