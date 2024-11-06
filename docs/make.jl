using TDAnalyze
using Documenter

DocMeta.setdocmeta!(TDAnalyze, :DocTestSetup, :(using TDAnalyze); recursive=true)

makedocs(;
    modules=[TDAnalyze],
    authors="ArrogantGao <gaoxuanzhao@gmail.com> and contributors",
    sitename="TDAnalyze.jl",
    format=Documenter.HTML(;
        canonical="https://ArrogantGao.github.io/TDAnalyze.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/ArrogantGao/TDAnalyze.jl",
    devbranch="main",
)
