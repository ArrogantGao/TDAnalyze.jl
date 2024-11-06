using TDAnalyze
using Test

using OMEinsum, TreeWidthSolver, GenericTensorNetworks
using TreeWidthSolver.Graphs, TreeWidthSolver.AbstractTrees

using Random
Random.seed!(1234)

@testset "TDAnalyze.jl" begin
    include("tree_decomposition.jl")
end
